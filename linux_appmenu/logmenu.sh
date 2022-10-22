#!/usr/bin/perl
#Menu v3.1.0
#Developer:
#Brian Davidson

chomp($user=`whoami`);
if($user ne "root")
{
        print "You must be root to run the menu!\n";
        exit (1);
}


$MENUFILENAME="/opt/cubic_appmenu/menu_config/logmenu.lst";
if( $#ARGV eq 0 )
{
        $MENUFILENAME=$ARGV[0];
}

# as long as the E(x)it option is not chosen,
# execute the menu option and then display
# the menu again and ask for another choice

while ( uc($pick) ne "X" and !($behavior =~ "exit") and uc($pick) ne "EXIT" )
{
    get_menu_pick();
        do_pick();
}

# clear the screen and exit with 0 return code

clear_screen();
exit (0);

#---------------------
# END Main
#---------------------

# Clear the screen, Show the menu and get user input
sub get_menu_pick
{
        clear_screen();
        show_menu();
        get_pick();
}

# Clear the screen
sub clear_screen
{
        system clear;
}

# Open menufile.txt or exit with an error
# read in each row picking up the first two fields by
# splitting it on the pipe |
# send some form feeds to do some centering
sub show_menu
{
        $count = 0;

        chomp($host=`uname -n`);
        #chomp($user=`whoami`);
        #chomp($dev=`who am i | /usr/bin/awk "{print $2}"`);
        $sudo="/usr/local/bin/sudo";
        chomp($DATE=`date '+%A %m/%d/%Y'`);
        $title="false";
        print "\n\n";

        open( MENUFILE, "$MENUFILENAME") or die ("Can't open $MENUFILENAME: $!\n");
        while ($menurow=<MENUFILE>)
        {
                ($menupick,$menuprompt)=split (/:/,$menurow);
                if($menupick eq "title")
                {
                        print "\t$menuprompt\n";
                        ++$count;
                        $title="true";
                }
                else
                {
                        if($title ne "true")
                        {
                                print "\tOperator Menu for $host on $DATE\n\n";
                                $title="true";
                        }
                        if($menuprompt =~ m/WEB/ )
                        {
                                chomp($VAR=`cat '/home/'|grep -v '#'|grep HTTP=|awk -F= '{print \$2}'`);
                                $menuprompt =~ s/WEB/$VAR/;
                        }
                        print "\t\t$menupick\t$menuprompt \n";
                }
                ++$count;
        }
        close MENUFILE;
        $count = (22 - $count ) /2;
        for ($i=0; $i < $count; ++$i){
                print "\n";
        }
        print "\n\n\tEnter your selection: ";
}

# get user input and chop off the newline
sub get_pick()
{
        chomp($pick = <STDIN>);
}

sub do_pick()
{
        open( MENUFILE, "$MENUFILENAME") or die ("Can't open $MENUFILENAME: $!\n");
        $foundpick = "false";
        $behavior = "nothing";
        while ($menurow=<MENUFILE>)
        {
                ($menupick, $menuprompt, $menucommand, my($menuBehavior))=split (/:/,$menurow);
                if (uc($menupick) eq uc($pick))
                {
                        system $menucommand;
                        $foundpick = "True";
                        $behavior = "$menuBehavior";
                        break;
                }
        }
        close MENUFILE;
        if ($foundpick eq "false" and uc($pick) ne "EXIT")
        {
                error_press_enter();
        }
        elsif($behavior =~ "enter")
        {
                wait_enter();
        }
}

# put up a message and wait for user to press ENTER
sub error_press_enter
{
        print "\n\nYou have entered an invalid option . . .\n";
        wait_enter();
}

sub wait_enter
{
        print "Press <Enter> to Continue . . .\n";
        $dummy = <STDIN>;
}

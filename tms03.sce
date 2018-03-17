#header
default_background_color = 255, 255, 255;
default_text_color = 0, 0, 0;

#nužno za TMS
response_logging = log_active; 
write_codes=true;
pulse_width=1;

#nuzno za press for pause
active_buttons=2;
response_matching=simple_matching;

begin;
#SDL kod

picture{
	text{
		caption="+";
		font_size=48;
	};
	x=0; y=0;
}fiksacija;
	
trial{
	trial_duration = 5000;
	
	picture fiksacija;
	time=0;
}pocetak;

trial{
	trial_duration = 500;
	picture{
		background_color = 255, 255, 255; 
	};
	time=0;
}trial_blank;

wavefile { preload = false; } wave1;

trial {    
   trial_duration = 500;
	picture{
		background_color = 255, 255, 255; 
	};
	#time=0;
	
   stimulus_event {
	nothing{};
	#time=0;
   }event_beep;
}trial_beep;


#trial
#{
#	stimulus_event 
#	{
#		nothing 
#		{};
#		time=10;
#		port_code=0;
#	}TMS_ok1;
#}trial_tms;


trial{
	trial_duration = 5000;
	trial_type=correct_response;
	all_responses=false;
	
	picture{
			text{
				caption="Jeste li osjetili taktilni stimulus u ruci? \nPritisnite B za privremenu stanku.";
				font_size=48;
			};
		x=0; y=0;
	}text_pitanje;
	response_active=true;
	target_button=1;
	time=0;
}trial_pitanje;

trial{
	trial_duration = forever;
	trial_type=correct_response;
	
	picture{
			text{
				caption="Pauza. \nPritisnite N za nastavak.";
				font_size=48;
			};
		x=0; y=0;
	}text_pauza;
	target_button = 2;
}trial_pauza;

begin_pcl;
#PCL kod

#	#BEEP
#frekvencije "beep" zvuka
array<double> frequencies[6] = { 500., 800., 1100., 1400., 1700., 2000. };
sound beep;
#new sine object with the specified wavefile::duration, sine::frequency and sine::phase.
asg::sine sine_wave = new asg::sine( 500., 0., 0. );
#promijeni "frequencies" argument za drugu frekvenciju beep-a
sine_wave.set_frequency( frequencies[1] );
wave1 = new wavefile( sine_wave );
beep = new sound( wave1 );
event_beep.set_stimulus( beep );


pocetak.present();
trial_beep.present();
trial_blank.present();
#trial_tms.present();
trial_pitanje.present();

#za pauzu, "because we only have one response active...20"
#stimulus_data last=stimulus_manager.last_stimulus_data();
stimulus_data last=stimulus_manager.get_stimulus_data(1);
if(last.button() == 1) then
	trial_pauza.present();
#else
	#opet vrti petlju
end;
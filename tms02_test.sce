#header

default_background_color = 255, 255, 255;
default_text_color = 0, 0, 0;

#nužno za TMS
response_logging = log_active; 
write_codes=true;
pulse_width=1;


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


trial
{
	stimulus_event 
	{
		nothing 
		{};
		time=10;
		port_code=0;
	}TMS_ok1;
}trial_tms;

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
trial_tms.present();
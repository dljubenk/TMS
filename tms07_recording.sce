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

trial {
	sound_recording
	{
	duration = 4000;
	#ovdje namjestiti gdje se spremaju audio snimke
	base_filename = "D:\DOWNLOADS";
	use_counter = true;
	use_date_time = true;
	};
	deltat = 0;
}trial_record;

#ovo je prvi izlaz za tms
trial
{
	stimulus_event 
	{
		nothing 
		{};
		time=10;
		port_code=1;
	}TMS_ok1;
}trial_tms;

#ovo je drugi izlaz za vibracijski stim
trial
{
	stimulus_event 
	{
		nothing 
		{};
		time=10;
		port_code=2;
	}TMS_ok2;
}trial_stim;

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

#nizovi delayeva - 1.način
#odgovarajući niz se odkomentira
#array<int> delays[26] = {20, 250, 50, 20, 50, 20, 200, 100, 50, 100, 200, 200, 150, 150, 250, 250, 200, 20, 100, 50, 100, 150, 250, 150, 20, 20};
#array<int> delays[26] = {150, 150, 250, 200, 100, 250, 250, 20, 100, 50, 150, 250, 50, 100, 200, 100, 150, 20, 20, 20, 200, 200, 50, 50, 20, 20};
#array<int> delays[26] = {200, 250, 250, 50, 50, 20, 200, 150, 200, 100, 50, 150, 250, 20, 100, 100, 150, 100, 20, 150, 200, 250, 20, 50, 20, 20};
#array<int> delays[26] = {20, 200, 100, 50, 50, 50, 250, 200, 50, 20, 200, 100, 20, 100, 150, 200, 20, 150, 250, 150, 250, 250, 100, 150, 20, 20};
#array<int> delays[26]; delays.fill(1, 26, 20, 0);
#nizovi delayeva - 1.način KRAJ

#nizovi delayeva - 2.način
array<int> possibleDelays[6] = {20, 50, 100, 150, 200, 250};
#ovdje se jednostavno može promijeniti broj izmjena triala
array<int> delays[26];
loop int i = 1 until i > delays.count()
begin
	possibleDelays.shuffle();
	delays[i] = possibleDelays[1];
	i = i + 1;
end;
#nizovi delayeva - 2.način KRAJ

loop int i = 1 until i > delays.count()
begin 
	pocetak.present();
	trial_beep.present();
	trial_blank.present();
	#trial_tms.delay = delays[i];
	TMS_ok1.set_time(delays[i]);
	trial_stim.present();
	trial_tms.present();
	trial_pitanje.present();
	trial_record.present();

	#za pauzu, "because we only have one response active...20"
	stimulus_data last=stimulus_manager.last_stimulus_data();
	#stimulus_data last=stimulus_manager.get_stimulus_data(1);
	if(last.button() == 1) then
		trial_pauza.present();
	end;
	
	i = i + 1;
end;
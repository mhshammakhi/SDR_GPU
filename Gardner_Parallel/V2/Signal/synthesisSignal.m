tb = randi([0,3], 999980, 1);
d_mod = pskmod(tb,4, pi/4);
SPS   = 5;
t_RC = comm.RaisedCosineTransmitFilter(...
    'RolloffFactor',          0.35,...
    'FilterSpanInSymbols',    20,...
    'OutputSamplesPerSymbol', 25);
d_bb = t_RC(d_mod);
d_bb_ch = awgn(d_bb, 100);
r_RC = comm.RaisedCosineReceiveFilter(...
    'RolloffFactor',         0.35,...
    'FilterSpanInSymbols',   20,...
    'InputSamplesPerSymbol', 25,...
    'DecimationFactor',      t_RC.OutputSamplesPerSymbol / SPS,...
    'DecimationOffset',      0);
d_bb_r = r_RC(d_bb_ch);
data_length = length(d_bb_r);
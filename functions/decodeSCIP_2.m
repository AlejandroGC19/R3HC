% Function to decode range information transmitted using SCIP2.0 protocol.
% Works for only two and three bit encoding.
% Author- Shikhar Shrestha, IIT Bhubaneswar
function rangeval=decodeSCIP_2(rangeenc)
    % Check for 2 or 3 Character Encoding
    if rangeenc(1)=='0' && rangeenc(2)=='0' && rangeenc(3)=='0'
        rangeval=0;
        return;
    end
    if rangeenc(1)=='0'    
        dig1sub=rangeenc(2)-48;
        dig2sub=rangeenc(3)-48;
        rangeval=dig1sub*64+dig2sub;

        return;
    else    
        dig1sub=rangeenc(1)-48;
        dig2sub=rangeenc(2)-48;
        dig3sub=rangeenc(3)-48;
        rangeval=dig1sub*4096+dig2sub*64+dig3sub;
        return;

    end
end
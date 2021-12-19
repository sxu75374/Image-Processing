function MBVQ_name = determine_MBVQ(R,G,B)
if(R+G) > 255
    if(G+B) > 255
        if(R+G+B) > 510
            MBVQ_name = 'CMYW';
        else
            MBVQ_name = 'MYGC';
        end
    else
        MBVQ_name = 'RGMY';
    end
else 
    if(G+B) <= 255
        if(R+G+B) <= 255
            MBVQ_name = 'KRGB';
        else
            MBVQ_name = 'RGBM';
        end
    else
        MBVQ_name =  'CMGB';
    end
           
end
end
                    
                
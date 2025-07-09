function rgb = hex2rgb(hex)
if isstring(hex)
    hex = char(hex);
end
if hex(1) == '#'
    hex = hex(2:end);  % Remove '#'
end
rgb = reshape(sscanf(hex, '%2x')', 1, []) / 255;
end

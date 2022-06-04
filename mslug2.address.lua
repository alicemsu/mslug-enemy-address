print("mslug2 show enemy address lua for fba-rr, fbneo");
print("V1.0 by Alice, CZXInc");

eList = {};
eDataList = {};
removeList = {};

function fun()
    eList[#eList + 1] = memory.getregister("m68000.a0");
    eDataList[#eDataList + 1] = memory.getregister("m68000.a1");

    print("enemy! ram:"..string.format("%06X", eList[#eList]).." rom:"..string.format("%06X", eDataList[#eDataList]))
end

function draw()
    for i = #eList,1 ,-1 do
        if(memory.readdword(eList[i]) == 0x214a)then
            removeList[#removeList + 1] = i
        else
            x = memory.readword(eList[i] + 0x3c);
            y = 224 - (memory.readword(eList[i] + 0x40) - 0x100);
            gui.box(x - 2, y - 1, x + 24, y + 7,"clear", "red")
            gui.text(x, y, string.format("%06X", eDataList[i]),"white","black");   
        end
    end

    if(#removeList ~= 0)then
        for i = 1, #removeList do
            table.remove(eList, removeList[i]);
            table.remove(eDataList, removeList[i]);
        end
    end
    removeList = {};
end

memory.registerexec(592034, fun)
emu.registerafter(draw)
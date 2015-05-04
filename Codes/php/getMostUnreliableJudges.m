function id = getMostUnreliableJudges(W)
    id = find(W == min(W));
end
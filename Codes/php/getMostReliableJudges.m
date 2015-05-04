function id = getMostReliableJudges(W)
    id = find(W == max(W));
end
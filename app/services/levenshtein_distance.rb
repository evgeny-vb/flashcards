# frozen_string_literal: true

# Module to calculate Levenshtein Distance
# Gems are working incorrect with unicode
#
module LevenshteinDistance
  module_function

  def calculate(s1, s2)
    d = {}
    (0..s1.size).each { |row| d[[row, 0]] = row }
    (0..s2.size).each { |col| d[[0, col]] = col }

    (1..s1.size).each do |i|
      (1..s2.size).each do |j|
        cost = 0
        cost = 1 if s1[i - 1] != s2[j - 1]

        d[[i, j]] = [d[[i - 1, j]] + 1,
                     d[[i, j - 1]] + 1,
                     d[[i - 1, j - 1]] + cost].min

        next unless i > 1 && j > 1 && s1[i - 1] == s2[j - 2] && s1[i - 2] == s2[j - 1]
        d[[i, j]] = [d[[i, j]],
                     d[[i - 2, j - 2]] + cost
        ].min
      end
    end
    d[[s1.size, s2.size]]
  end
end

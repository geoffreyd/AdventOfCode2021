# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

cave_connections = input.map { _1.split('-')}
pp cave_connections

@caves = {}

cave_connections.each do |connection|
  l, r = connection
  @caves[l] ||= []
  @caves[l] << r
  @caves[r] ||= []
  @caves[r] << l
end

pp @caves

@paths = []

def dig(node, prev, small_visits, path)
  # pp "Small Visits - #{small_visits}"
  if node == 'end'
    @paths << path
    return
  end
  nexts = @caves[node] - small_visits

  nexts.each do |next_cave|
    # pp "visiting #{next_cave} - #{path}"
    new_small = if next_cave.match(/^[a-z]+$/)
      small_visits + [next_cave]
    else
      small_visits
    end

    dig(next_cave, node, new_small, path + [next_cave])
  end
end

dig('start', nil, ['start'], ['start'])

pp @paths

pp @paths.count
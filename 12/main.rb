# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

cave_connections = input.map { _1.split('-')}
# pp cave_connections

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

def dig(node, _prev, small_visits, path)
  # pp "Small Visits - #{small_visits}"
  if node == 'end' || path.length > 100
    @paths << path
    return
  end

  small_twice = small_visits.any? { |k, v| v > 1 && k != 'start' }
  smalls = small_twice ? small_visits.keys : []
  nexts = @caves[node] - smalls - ['start']

  nexts.each do |next_cave|
    # pp "visiting #{next_cave} - #{path}"
    new_small = if next_cave.match(/^[a-z]+$/)
                  r = small_visits.clone
                  r[next_cave] += 1
                  r
                else
                  small_visits
                end

    dig(next_cave, node, new_small, path + [next_cave])
  end
end

visits = Hash.new { 0 }

dig('start', nil, visits, ['start'])

# pp @paths

pp @paths.count

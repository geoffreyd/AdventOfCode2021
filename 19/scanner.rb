class Scanner

  attr_accessor :id, :beacons, :scanner_location

  def initialize(id, beacons)
    @id = id
    @beacons = beacons
    @beacons_never_overlapped = beacons.dup
    @scanner_location = [0,0,0]
  end

  def update_scanner_location(scanner)
    other_location = scanner.scanner_location
    # @scanner_location ||=
  end

  def point_distances
    @distances ||= @beacons.map do |beacon|
      @beacons.map do |other_beacon|
        distance_between_points(beacon, other_beacon) if beacon != other_beacon
      end.compact
    end
  end

  def process_scanner(scanner)
    overlaps = overlapping_beacons(scanner)
    @beacons_never_overlapped.delete_if { |beacon| overlaps.include?(beacon) }
    overlaps
  end

  def sorted_distances
    @sorted_distances ||= point_distances.sort
  end

  def overlapping(scanner)
    return false if scanner == self
    overlap_ids = []
    overlaps = self.point_distances.map.with_index do |point, idx|
      scanner.point_distances.any? do |other_point|
        overlaps = point.intersection(other_point)
        # if overlaps.length > 0
        #   pp "Comparting #{point.sort} with #{other_point.sort}"
        #   pp "Found #{overlaps.length} intersections - #{overlaps}"
        # end
        overlaps.length >= 10
      end ? idx : nil
    end.compact
    # pp "Overlaps: #{overlaps.length}"
    overlaps
  end

  def overlapping_beacons(scanner)
    overlapping(scanner).map { |idx| @beacons[idx] }
  end

  def distance_between_points(a, b)
    x1, y1, z1 = a
    x2, y2, z2 = b

    (x1 - x2).abs + (y1 - y2).abs + (z1 - z2).abs
  end

end
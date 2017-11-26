# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
    {
        sensor: {sigfox_id: '37889A', fullness_pct: 0},
        sump: {latitude: 50.091543, longitude: 14.45488, phone: '+420777894022', name: 'Forum Karlín', address_street: '', address_city: 'Prague'}
    },

    {
        sensor: {sigfox_id: '37DB96', fullness_pct: 0},
        sump: {latitude: 50.100481, longitude: 14.447855, phone: '+420777894022', name: 'Alza.cz', address_street: '', address_city: 'Prague'}
    },

    {
        sensor: {sigfox_id: 'A', fullness_pct: 53},
        sump: {latitude: 50.10174, longitude: 14.432354, phone: '+420777894022', name: 'Veletržní palác', address_street: '', address_city: 'Prague'}
    },

    {
        sensor: {sigfox_id: 'B', fullness_pct: 12},
        sump: {latitude: 50.10174, longitude: 14.432354, phone: '+420777894022', name: 'Oliver Queen', address_street: '', address_city: 'Prague'}
    },

    {
        sensor: {sigfox_id: 'C', fullness_pct: 8},
        sump: {latitude: 50.10174, longitude: 14.432354, phone: '+420777894022', name: 'Phil Coulson', address_street: '', address_city: 'Prague'}
    },

    {
        sensor: {sigfox_id: 'D', fullness_pct: 33},
        sump: {latitude: 50.10174, longitude: 14.432354, phone: '+420777894022', name: 'Bruce Wayne', address_street: '', address_city: 'Prague'}
    },

    {
        sensor: {sigfox_id: 'E', fullness_pct: 41},
        sump: {latitude: 50.10174, longitude: 14.432354, phone: '+420777894022', name: 'Darth Vader', address_street: '', address_city: 'Prague'}
    },

    {
        sensor: {sigfox_id: 'F', fullness_pct: 24},
        sump: {latitude: 50.10174, longitude: 14.432354, phone: '+420777894022', name: 'Tony Stark', address_street: '', address_city: 'Prague'}
    },
].each do |data|
  sensor = Sensor.create(data[:sensor])

  Sump.create(data[:sump].merge({sensor_id: sensor.id}))
end
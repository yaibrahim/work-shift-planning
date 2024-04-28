# Work shift Service
`Build a REST application from scratch that could serve as a work planning service. `

`Business requirements:`

`A worker has shifts A shift is 8 hours long.`

`A worker never has two shifts on the same day.`

`It is a 24 hour timetable 0-8, 8-16, 16-24.`

# API Documentation

## localhost:3000/workers `(POST)`
### Worker register body parameter example
```
   {
        "worker": {
        "name": "Ibrahim"
        }
    }
```

## localhost:3000/shifts `(POST)`
`Retrive Auth token for authentication purpose`
```
    {
        "shift": {
            "start_time": "2024-04-29T11:00:00",
            "end_time": "2024-04-29T16:00:00",
            "date": "2024-04-29",
            "worker_id": 8
        }
    }
```

## localhost:3000/workers `(GET)`

## localhost:3000/workers/:id `(GET)`

## localhost:3000/shifts `(GET)`

## localhost:3000/workers/:id/shifts `(GET)`


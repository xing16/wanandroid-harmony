@Observed
export class User {
  name: string
  car?: Car

  constructor(name: string, car?: Car) {
    this.name = name;
    this.car = car;
  }
}

@Observed
export class Car {
  brand: string
  engine?: Engine

  constructor(brand: string, engine?: Engine) {
    this.brand = brand;
    this.engine = engine;
  }
}

export class Engine {
  type?: string

  constructor(type: string) {
    this.type = type;
  }
}
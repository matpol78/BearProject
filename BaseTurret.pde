class BaseTurret {
	
	
	//This class is not implemented at the moment
	
	//position variables
	private int posX = width/2+50;
	private int posY = height-50;
	private int posX2 = width/2+50;
	private int posY2= height-15;
	//asthetic Options
	private int lineStrokeWeight = 20;
	private int redRGBValue = 0;
	private int greenRGBValue = 0;
	private int blueRGBValue = 0;
	
	private int fireRate = 1;
	private int turretTime = 0;
	
	private int counter = 0;
	
	List<BaseTurretBullet> baseTurretBullets = new ArrayList<BaseTurretBullet>();
	
	EnemyBasic closest;
	
	public BaseTurret(){}
	
	
	
	EnemyBasic determineClosestShip() {
		closest = basicEnemies.get(0);
		double smallestDistance = sqrt(basicEnemies.get(0).getDistanceFromBaseX()*basicEnemies.get(0).getDistanceFromBaseX()+basicEnemies.get(0).getDistanceFromBaseY()*basicEnemies.get(0).getDistanceFromBaseY());
		//iterate through all the ships and apply the distance formula to determine the closest one
		for (int i = 0; i < basicEnemies.size();i++){
			if (sqrt(basicEnemies.get(i).getDistanceFromBaseX()*basicEnemies.get(i).getDistanceFromBaseX()+basicEnemies.get(i).getDistanceFromBaseY()*basicEnemies.get(i).getDistanceFromBaseY()) < smallestDistance) {
				smallestDistance = sqrt(basicEnemies.get(i).getDistanceFromBaseX()*basicEnemies.get(i).getDistanceFromBaseX()+basicEnemies.get(i).getDistanceFromBaseY()*basicEnemies.get(i).getDistanceFromBaseY());
				closest = basicEnemies.get(i);
			}
			
		}
		return closest;
	}
	
	public void updatePos(){
		EnemyBasic closest= determineClosestShip();
		posX = closest.getX();
		posY = closest.getY();
		
	}
	
	public void display() {
		System.out.println("BaseTurret Display Loop");
		if (basicEnemies.size() > 0) {
			updatePos();
		}		
		turretTime++;
		shoot();
		checkForHit();
		strokeWeight(lineStrokeWeight);
		stroke(redRGBValue,greenRGBValue,blueRGBValue);
		line(posX,posY,posX2,posY2);
		for(int i = 0; i < baseTurretBullets.size(); i++) {
			System.out.println("Displaying Base Turret Bullets");
			System.out.println(".");
			baseTurretBullets.get(i).display();
		}
	}
	
	void shoot() {
		if (turretTime % 30 == 0) {
			//System.out.println("Made IT");
			baseTurretBullets.add(new BaseTurretBullet(posX2,posY2,closest.getX(),closest.getY()));
		}
	}
	
	void checkForHit() {
		System.out.println("Check For Hit");
		if (baseTurretBullets.size() > 0 ) {
			System.out.println("Bullets are not zero");
			if (abs(baseTurretBullets.get(counter).getX()-closest.getX()) <= 100 && abs(baseTurretBullets.get(counter).getY()-closest.getY()) <= 100) {
				System.out.println("We exploding this boi");
				baseTurretBullets.get(counter).explode();
				counter++;
			}
		}
	}
	
}


//I need to check bullet hits for all objects on screen, not just the closest one.


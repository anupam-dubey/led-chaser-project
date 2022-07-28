int digpins[12]={13,0,1,12,11,10,9,8,7,6,5,2};
int i;
void setup() {
  // put your setup code here, to run once:
 
 for(i=0;i<12;i++)
 {
  pinMode(digpins[i],OUTPUT);
 }
  for(i=0;i<12;i++)
 {
  digitalWrite(digpins[i],LOW);
 }
}

void loop() {
  // put your main code here, to run repeatedly:
 for(i=0;i<12;i++)
 {
  digitalWrite(digpins[i],HIGH);
 }
 delay(1000);

  for(i=0;i<12;i++)
 {
  digitalWrite(digpins[i],LOW);
 }
 delay(1000);
}

/*
.set("size",width,height);
.set("time",frameCount);
.set("param",split);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

#define PI 3.1415926

void main()
{
	float angle=atan(gl_FragCoord.y-float(size.y/2),gl_FragCoord.x-float(size.x/2));
	angle+=time*.01;
	angle=mod(angle,PI/3.*2.);
	if(PI/3.<angle)angle=PI/3.*2.-angle;
	angle+=param*PI*2.;

	float dist=length(gl_FragCoord.xy-size/2);
	dist=mod(dist,min(size.x,size.y));
	if(min(size.x,size.y)/2<dist)dist=min(size.x,size.y)-dist;

	gl_FragColor=texelFetch(texture,ivec2(size.x/2+cos(angle)*dist,size.y/2+sin(angle)*dist),0);
}
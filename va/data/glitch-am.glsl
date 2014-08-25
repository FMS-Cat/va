/*
.set("size",width,height);
.set("time",frameCount);
.set("param",amount);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

float noise(float seed)
{
	return fract(sin(seed*3287.5456)*3982.344);
}

void main()
{
	float t=floor(time*.5);
	float my=gl_FragCoord.y;
	float mo=noise(floor((my+time)*.07+noise(floor(my*1.1))));
	ivec2 p=ivec2(mod(gl_FragCoord.x+(.4*mo-.2)*param*size.x,size.x),gl_FragCoord.y);
	gl_FragColor=texelFetch(texture,p,0);
}
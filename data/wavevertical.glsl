/*
.set("size",width,height);
.set("time",frameCount);
.set("param",amp,freq,offset,n/a);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

#define PI 3.1415926

void main()
{
	gl_FragColor=texelFetch(texture,ivec2(gl_FragCoord.x,clamp(gl_FragCoord.y+sin((gl_FragCoord.x*param*.2+time*.05)*PI*2)*param*size.y*.2,0.,size.y-1.)),0);
}
/*
.set("size",width,height);
.set("time",frameCount);
.set("param",theta);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

void main()
{
	gl_FragColor=texelFetch(texture,ivec2(gl_FragCoord.x,mod(gl_FragCoord.y+param*size.y*20.,size.y)),0);
}
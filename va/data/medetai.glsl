/*
.set("size",width,height);
.set("time",frameCount);
.set("param",amount);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

#define PI 3.1415926

void main()
{
	vec2 v=vec2(0,1);
	vec4 col=v.yxxy;
	if(mod(atan(gl_FragCoord.y-size.y/2,gl_FragCoord.x-size.x/2)+time*.004*PI*2,PI/8.)<PI/16.)
	{
		col=v.yyxy;
	}else{
		col=v.yxxy;
	}
	gl_FragColor=col*param+texelFetch(texture,ivec2(gl_FragCoord.xy),0)*(1.-param);
}
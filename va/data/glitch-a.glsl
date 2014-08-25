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
	float my=gl_FragCoord.y+time+t*22.29;
	float mo=noise(floor(my*.07+noise(floor(my*1.1)))+t*.29);
	float ms=noise(floor(my*.07+noise(floor(my*1.1)))+t*.54);
	ivec2 p=ivec2(mod(gl_FragCoord.x+(.4*noise(ms)-.2)*size.x,size.x),gl_FragCoord.y);
	if(-.1+param*1.1<mo)
	{
		gl_FragColor=texelFetch(texture,ivec2(gl_FragCoord.xy),0);
	}else if(ms<.2){
		gl_FragColor=texelFetch(texture,p,0)*3.;
	}else if(ms<.4){
		gl_FragColor=texelFetch(texture,ivec2(2,gl_FragCoord.y),0);
	}else{
		gl_FragColor=texelFetch(texture,p,0);
	}
}
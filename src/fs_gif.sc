$input v_texcoord0

/*
 * Copyright 2011-2019 Branimir Karadzic. All rights reserved.
 * License: https://github.com/bkaradzic/bgfx#license-bsd-2-clause
 */

#include "../thirdparty/bgfx/examples/common/common.sh"

SAMPLER2D(s_texColor,  0);
uniform vec4 u_time;

void main()
{
	vec2 t = v_texcoord0.xy;
	t.y *= u_time.x;
	t.y += u_time.y;
	vec4 color = texture2D(s_texColor, t);
	gl_FragColor = color;
}

From: "Fabien Marteau" <fabien.marteau-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: Re: Simple read byte data compilation problem
Date: Tue, 21 Oct 2008 18:10:36 +0200
Message-ID: <ce62e9d00810210910u7a2765e1q9e2e236c8b979a9a@mail.gmail.com>
References: <ce62e9d00810210244p3194a50fj3b6b19209465ac7e@mail.gmail.com>
	<20081021145956.4a65467e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1585549807941642143=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081021145956.4a65467e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============1585549807941642143==
Content-Type: multipart/alternative;
	boundary="----=_Part_9209_23843224.1224605436966"

------=_Part_9209_23843224.1224605436966
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
>
> Documentation/i2c/dev-interface says:
>
> So let's say you want to access an i2c adapter from a C program. The
> first thing to do is "#include <linux/i2c-dev.h>". Please note that
> there are two files named "i2c-dev.h" out there, one is distributed
> with the Linux kernel and is meant to be included from kernel
> driver code, the other one is distributed with i2c-tools and is
> meant to be included from user-space programs. You obviously want
> the second one here.
>



>
> Apparently you missed this paragraph.
>


Yes, in fact I looked for i2c-dev.h in the wrong  tree (lm-sensor). I
realize that they are i2c-tools special tree for this. That work fine know.

Thank you
FabM


>
> As a side note, if you only need to test your bus driver, the
> i2cdetect, i2cget, i2cset and i2cdump utilities from the i2c-tools
> package should be a good start, maybe you don't need to write your own
> utility.
>
> --
> Jean Delvare
>
>
>

------=_Part_9209_23843224.1224605436966
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div class="Wj3C7c"><br>
</div></div>Documentation/i2c/dev-interface says:<br>
<br>
So let&#39;s say you want to access an i2c adapter from a C program. The<br>
first thing to do is &quot;#include &lt;linux/i2c-dev.h&gt;&quot;. Please note that<br>
there are two files named &quot;i2c-dev.h&quot; out there, one is distributed<br>
with the Linux kernel and is meant to be included from kernel<br>
driver code, the other one is distributed with i2c-tools and is<br>
meant to be included from user-space programs. You obviously want<br>
the second one here.<br>
</blockquote><div><br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
Apparently you missed this paragraph.<br>
</blockquote><div><br><br>Yes, in fact I looked for i2c-dev.h in the wrong&nbsp; tree (lm-sensor). I realize that they are i2c-tools special tree for this. That work fine know.<br><br>Thank you<br>FabM<br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
As a side note, if you only need to test your bus driver, the<br>
i2cdetect, i2cget, i2cset and i2cdump utilities from the i2c-tools<br>
package should be a good start, maybe you don&#39;t need to write your own<br>
utility.<br>
<br>
--<br>
<font color="#888888">Jean Delvare<br>
<br>
<br>
</font></blockquote></div><br>

------=_Part_9209_23843224.1224605436966--


--===============1585549807941642143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============1585549807941642143==--

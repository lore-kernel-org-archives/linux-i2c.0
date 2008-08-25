From: "naveen krishna ch" <naveenkrishna.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i2c 2 issues on omap3430
Date: Mon, 25 Aug 2008 12:48:04 +0530
Message-ID: <ef0d8a250808250018w587c2de0s726511c52c0794e3@mail.gmail.com>
References: <ef0d8a250808250005sbf8bb8cg9cfacc6a6f2b4195@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6847649750451175442=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <ef0d8a250808250005sbf8bb8cg9cfacc6a6f2b4195-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============6847649750451175442==
Content-Type: multipart/alternative;
	boundary="----=_Part_65032_21238878.1219648684231"

------=_Part_65032_21238878.1219648684231
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
    I am facing some i2c issues on omap3430 with linux 2.6.24 kernel.

    My device is a slave sitting on I2C2 of OMAP3430.

    I am observing the following,
     1) Sometimes i get "i2c_omap.2: controller timed out"

                   i2c_omap.2: No acknowledmentif i use i2c 2 at 100khz
        and i dont find them when i run at 400khz.

     2) Sometimes the i2c write and read succeeds but data received is junk.

     3) The I2C reads are not consistent. with same image if i boot
several times

        The readed values keep variying.

      I am not sure what could be the problem. The mux settings seems okay.

     The client creation seems fine. Can any one suggest me the exact
     i2c bus registration steps. right now i only have


omap_register_i2c_bus(1, CONFIG_I2C_OMAP34XX_HS_BUS1, NULL, 0);

in the board file. and

MUX configurations in the

arch/arm/plat-omap/i2c.c
arch/arm/mach-omap2/mux.c
include/asm/arch/mux.h

files

     Am i missing something?

     Please advice,


-- 
Thanks,
(: Naveen Krishna Ch :)

------=_Part_65032_21238878.1219648684231
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><div class="gmail_quote"><br><br><div dir="ltr"><pre>Hi,<br>    I am facing some i2c issues on omap3430 with linux 2.6.24 kernel.<br><br>    My device is a slave sitting on I2C2 of OMAP3430.<br><br>    I am observing the following,<br>
     1) Sometimes i get &quot;i2c_omap.2: controller timed out&quot; <br>
                   i2c_omap.2: No acknowledmentif i use i2c 2 at 100khz<br>        and i dont find them when i run at 400khz.<br> <br>     2) Sometimes the i2c write and read succeeds but data received is junk.<br><br>     3) The I2C reads are not consistent. with same image if i boot several times<br>

        The readed values keep variying.<br><br>      I am not sure what could be the problem. The mux settings seems okay.<br>      <br>     The client creation seems fine. Can any one suggest me the exact <br>     i2c bus registration steps. right now i only have <br>

        <br>omap_register_i2c_bus(1, CONFIG_I2C_OMAP34XX_HS_BUS1, NULL, 0);<br><br>in the board file. and  <br><br>MUX configurations in the <br><br>arch/arm/plat-omap/i2c.c<br>arch/arm/mach-omap2/mux.c<br>include/asm/arch/mux.h <br>

<br>files<br><br>     Am i missing something?<br><br>     Please advice,</pre><br>-- <br>Thanks, <br>(: Naveen Krishna Ch :)<br>
</div>
</div><br>
</div>

------=_Part_65032_21238878.1219648684231--


--===============6847649750451175442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============6847649750451175442==--

From: "naitik amin" <greatamin1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-stub
Date: Fri, 3 Oct 2008 13:07:00 -0400
Message-ID: <aea25fc40810031007i6a6fe090w64d0e4d8ecacb285@mail.gmail.com>
References: <aea25fc40810021503i13ea57cal183a7bf9bc88e351@mail.gmail.com>
	<20081003095647.5fb7f0de@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0377727273067599202=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081003095647.5fb7f0de-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

--===============0377727273067599202==
Content-Type: multipart/alternative;
	boundary="----=_Part_10842_10381419.1223053620776"

------=_Part_10842_10381419.1223053620776
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jean,

Please see my responses below (in bold).

Thanks,

On Fri, Oct 3, 2008 at 3:56 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> On Thu, 2 Oct 2008 18:03:35 -0400, naitik amin wrote:
> > I was trying to use the i2c-stub driver.
> >
> > What I did was I hardcoded the address to 0x23 and inserted the
> i2c-stub.ko
>
> Hard-coded? How, and why? The address is supposed to be passed as a
> module parameter:
>
> modprobe i2c-stub chip_addr=0x23
>


> *>>> I did it this way because doing insmod with argument gave me an
> error.*
>
 *insmod i2c-stub.ko chip_addr=0x23
 insmod: init_module 'i2c-stub.ko' failed (No such device)
This is may be because I am using Android Goldfish environment. So just to
go around I hardcoded it.
 *

> I then inserted ds1682.ko also part of the 2.6 kernel.

Which kernel version exactly?
> *>>> 2.6.25*
>


>
> > I was hoping to see that the probe function for ds1682.ko to be called
> but
> > it didn't.  Can someone comment on what I maybe missing.
>
> The ds1682 driver is a new-style driver, it doesn't scan the adapters
> for devices. Instead, kernel code must explicitly instantiate the
> devices. Alternatively, we could add a mechanism to instantiate devices
> from user-space, but it's not there yet.
>
> I don't think you will get it to work anyway, because the ds1682 driver
> makes use of I2C block transactions, which i2c-stub doesn't support
> yet. So you would have to add support for I2C block transactions first.
>

*   >>> Please see the insert below*

>
> > Oh and BTW I did change the i2c_board_info by calling
> > i2c_register_board_info in machine level init. The parameters that I had
> > here were "ds1362" for driver name and 0x23 for address.
>
> "ds1362"? The only device supported by the ds1682 driver is "ds1682".
> But the way I2C devices are matched changed recently, so it really
> depends on what exact kernel version you are using.
>
> Anyway, what are you trying to achieve in the first place?
> *>>>* *What I am trying to achieve is to automatically instantiate a i2c
> device from the board level init (something that you mentioned is not there
> yet). So thats what I was trying to do, correct me if I am wrong here, I am
> new to this architecture, but what my understanding is, *



>
>    - *under new style drivers, you have to populate i2c_board_info struct
>    and when i2c_new_device gets called creates it the i2c_client stance.*
>    - *so in order to add "ds1682" to i2c_board_info I did*
>
>          struct i2c_board_info __initdata goldfish_i2c_devices[] =
        {
            {
                I2C_BOARD_INFO("ds1682", 0x23),
            }
        };

        static void __init goldfish_init(void)
        {
             platform_device_register(&goldfish_pdev_bus_device);
             platform_device_register(&goldfish_vms_device);
             /* I2C */
             //goldfish_add_device_i2c(goldfish_i2c_devices,
ARRAY_SIZE(goldfish_i2c_devices));
             *i2c_register_board_info(0, goldfish_i2c_devices,
ARRAY_SIZE(goldfish_i2c_devices));*
         }

*         goldfish_init is called as a part of the board level init
(init_machine)*

>
>    - *So now with my i2c_board_info populated with ds1682, i modified
>    i2c-stub.c to hardcode it to 0x23 and inserted i2c-stub.ko*
>
>
>    - *looking at the code for i2c-stub.c, its init fn calls
>    i2c_add_adapter, it goes then goes through the i2c_board_info list and
>    should find "ds1682" and should go through source below
>    *
>
>
>    - *
>    i2c_add_adapter-->i2c_register_adapter-->i2c_scan_static_board_info-->i2c_new_device-->
>    i2c_attach_client*
>
>
>    - *So it should create a new i2c_client and attach to it.*
>
>
Is is a right way to do things ? Please let me know.



--
Jean Delvare

On Fri, Oct 3, 2008 at 3:56 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> On Thu, 2 Oct 2008 18:03:35 -0400, naitik amin wrote:
> > I was trying to use the i2c-stub driver.
> >
> > What I did was I hardcoded the address to 0x23 and inserted the
> i2c-stub.ko
>
> Hard-coded? How, and why? The address is supposed to be passed as a
> module parameter:
>
> modprobe i2c-stub chip_addr=0x23
>
> > I then inserted ds1682.ko also part of the 2.6 kernel.
>
> Which kernel version exactly?
>
> > I was hoping to see that the probe function for ds1682.ko to be called
> but
> > it didn't.  Can someone comment on what I maybe missing.
>
> The ds1682 driver is a new-style driver, it doesn't scan the adapters
> for devices. Instead, kernel code must explicitly instantiate the
> devices. Alternatively, we could add a mechanism to instantiate devices
> from user-space, but it's not there yet.
>
> I don't think you will get it to work anyway, because the ds1682 driver
> makes use of I2C block transactions, which i2c-stub doesn't support
> yet. So you would have to add support for I2C block transactions first.
>
> > Oh and BTW I did change the i2c_board_info by calling
> > i2c_register_board_info in machine level init. The parameters that I had
> > here were "ds1362" for driver name and 0x23 for address.
>
> "ds1362"? The only device supported by the ds1682 driver is "ds1682".
> But the way I2C devices are matched changed recently, so it really
> depends on what exact kernel version you are using.
>
> Anyway, what are you trying to achieve in the first place?
>
> --
> Jean Delvare
>

------=_Part_10842_10381419.1223053620776
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi Jean,<br><br>Please see my responses below (in bold).<br><br>Thanks,<br><br><div class="Ih2E3d">On Fri, Oct 3, 2008 at 3:56 AM, Jean Delvare <span dir="ltr">&lt;<a href="mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" target="_blank">khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org</a>&gt;</span> wrote:<br>

<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>On Thu, 2 Oct 2008 18:03:35 -0400, naitik amin wrote:<br>
&gt; I was trying to use the i2c-stub driver.<br>
&gt;<br>
&gt; What I did was I hardcoded the address to 0x23 and inserted the i2c-stub.ko<br>
<br>
</div>Hard-coded? How, and why? The address is supposed to be passed as a<br>
module parameter:<br>
<br>
modprobe i2c-stub chip_addr=0x23<br>
</blockquote><div>&nbsp;</div></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><b>&gt;&gt;&gt; I did it this way because doing insmod with argument gave me an error.</b></div>

</blockquote><div>&nbsp;<b>insmod i2c-stub.ko chip_addr=0x23<br>&nbsp;insmod: init_module &#39;i2c-stub.ko&#39; failed (No such device)<br>This is may be because I am using Android Goldfish environment. So just to go around I hardcoded it.<br>

&nbsp;</b></div><div class="Ih2E3d"><div><br>
&gt; I then inserted ds1682.ko also part of the 2.6 kernel.<br>
<br>
</div></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Which kernel version exactly?<br>
<div><b>&gt;&gt;&gt; 2.6.25</b></div></blockquote><div class="Ih2E3d"><div>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>
<br>
&gt; I was hoping to see that the probe function for ds1682.ko to be called but<br>
&gt; it didn&#39;t. &nbsp;Can someone comment on what I maybe missing.<br>
<br>
</div>The ds1682 driver is a new-style driver, it doesn&#39;t scan the adapters<br>
for devices. Instead, kernel code must explicitly instantiate the<br>
devices. Alternatively, we could add a mechanism to instantiate devices<br>
from user-space, but it&#39;s not there yet.<br>
<br>
I don&#39;t think you will get it to work anyway, because the ds1682 driver<br>
makes use of I2C block transactions, which i2c-stub doesn&#39;t support<br>
yet. So you would have to add support for I2C block transactions first.<br>
</blockquote></div><div>&nbsp; <br><b>&nbsp;&nbsp; &gt;&gt;&gt; Please see the insert below</b> <br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">
<div><br>
&gt; Oh and BTW I did change the i2c_board_info by calling<br>
&gt; i2c_register_board_info in machine level init. The parameters that I had<br>
&gt; here were &quot;ds1362&quot; for driver name and 0x23 for address.<br>
<br>
</div>&quot;ds1362&quot;? The only device supported by the ds1682 driver is &quot;ds1682&quot;.<br>
But the way I2C devices are matched changed recently, so it really<br>
depends on what exact kernel version you are using.<br>
<br>
Anyway, what are you trying to achieve in the first place?<br>
</div><b>&gt;&gt;&gt;</b> <b>What I am trying to achieve is to
automatically instantiate a i2c device from the board level init
(something that you mentioned is not there yet). So thats what I was
trying to do, correct me if I am wrong here, I am new to this
architecture, but what my understanding is, </b></blockquote>
<div>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><ul><li><b>under
new style drivers, you have to populate i2c_board_info struct and when
i2c_new_device gets called creates it the i2c_client stance.</b></li><li><b>so in order to add &quot;ds1682&quot; to i2c_board_info I did</b></li></ul></blockquote><div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_board_info __initdata goldfish_i2c_devices[] = <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2C_BOARD_INFO(&quot;ds1682&quot;, 0x23),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&nbsp; &nbsp; &nbsp; &nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void __init goldfish_init(void)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; platform_device_register(&amp;goldfish_pdev_bus_device);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; platform_device_register(&amp;goldfish_vms_device);<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* I2C */<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; //goldfish_add_device_i2c(goldfish_i2c_devices, ARRAY_SIZE(goldfish_i2c_devices));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>i2c_register_board_info(0, goldfish_i2c_devices, ARRAY_SIZE(goldfish_i2c_devices));</b><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goldfish_init is called as a part of the board level init (init_machine)</b><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<ul><li><b>So now with my i2c_board_info populated with ds1682, i modified i2c-stub.c to hardcode it to 0x23 and inserted i2c-stub.ko</b>&nbsp;</li></ul></blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<ul><li><b>looking at the code for i2c-stub.c, its init fn calls
i2c_add_adapter, it goes then goes through the i2c_board_info list and
should find &quot;ds1682&quot; and should go through source below<br></b></li></ul></blockquote>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><ul><li><b>i2c_add_adapter--&gt;i2c_register_adapter--&gt;i2c_scan_static_board_info--&gt;i2c_new_device--&gt;<br>

i2c_attach_client</b></li></ul></blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><ul><li><b>So it should create a new i2c_client and attach to it.</b></li>
</ul></blockquote><div>&nbsp; <br>Is is a right way to do things ? Please let me know.<br></div><div><br>&nbsp;&nbsp; <br></div>
<br>
--<br>
<font color="#888888">Jean Delvare</font><br><br><div class="gmail_quote">On Fri, Oct 3, 2008 at 3:56 AM, Jean Delvare <span dir="ltr">&lt;<a href="mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org">khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Thu, 2 Oct 2008 18:03:35 -0400, naitik amin wrote:<br>
&gt; I was trying to use the i2c-stub driver.<br>
&gt;<br>
&gt; What I did was I hardcoded the address to 0x23 and inserted the i2c-stub.ko<br>
<br>
</div>Hard-coded? How, and why? The address is supposed to be passed as a<br>
module parameter:<br>
<br>
modprobe i2c-stub chip_addr=0x23<br>
<div class="Ih2E3d"><br>
&gt; I then inserted ds1682.ko also part of the 2.6 kernel.<br>
<br>
</div>Which kernel version exactly?<br>
<div class="Ih2E3d"><br>
&gt; I was hoping to see that the probe function for ds1682.ko to be called but<br>
&gt; it didn&#39;t. &nbsp;Can someone comment on what I maybe missing.<br>
<br>
</div>The ds1682 driver is a new-style driver, it doesn&#39;t scan the adapters<br>
for devices. Instead, kernel code must explicitly instantiate the<br>
devices. Alternatively, we could add a mechanism to instantiate devices<br>
from user-space, but it&#39;s not there yet.<br>
<br>
I don&#39;t think you will get it to work anyway, because the ds1682 driver<br>
makes use of I2C block transactions, which i2c-stub doesn&#39;t support<br>
yet. So you would have to add support for I2C block transactions first.<br>
<div class="Ih2E3d"><br>
&gt; Oh and BTW I did change the i2c_board_info by calling<br>
&gt; i2c_register_board_info in machine level init. The parameters that I had<br>
&gt; here were &quot;ds1362&quot; for driver name and 0x23 for address.<br>
<br>
</div>&quot;ds1362&quot;? The only device supported by the ds1682 driver is &quot;ds1682&quot;.<br>
But the way I2C devices are matched changed recently, so it really<br>
depends on what exact kernel version you are using.<br>
<br>
Anyway, what are you trying to achieve in the first place?<br>
<br>
--<br>
<font color="#888888">Jean Delvare<br>
</font></blockquote></div><br></div>

------=_Part_10842_10381419.1223053620776--


--===============0377727273067599202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============0377727273067599202==--

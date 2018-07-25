From: Vitor Soares <Vitor.Soares@synopsys.com>
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
Date: Wed, 25 Jul 2018 09:43:48 +0100
Message-ID: <9fdfaf4e-5a20-af81-82ef-0d9e327f9133@synopsys.com>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
 <1532120272-17157-2-git-send-email-soares@synopsys.com>
 <CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
        boundary="------------99CD8D8374B6CE31411AECC4"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com>
Content-Language: pt-PT
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Vitor soares <Vitor.Soares@synopsys.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-i2c@vger.kernel.org

--------------99CD8D8374B6CE31411AECC4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Andy,


Às 4:35 PM de 7/21/2018, Andy Shevchenko escreveu:
> On Fri, Jul 20, 2018 at 11:57 PM, Vitor soares
> <Vitor.Soares@synopsys.com> wrote:
>> This patch add driver for Synopsys DesignWare IP on top of
>> I3C subsystem patchset proposal V6
> Some of comments below related to style.
> But unaligned helpers I think is good to use.
>
>> +#include <linux/bitops.h>

Bit operations API eg: GENMASK...

>> +#include <linux/clk.h>

Clock API eg: master->core_clk = devm_clk_get(&pdev->dev, "core_clk");

>> +#include <linux/completion.h>

Completion API eg: struct completion

>> +#include <linux/err.h>

Check kernel pointer eg: return PTR_ERR(master->regs);

>> +#include <linux/errno.h>

Error codes eg: return -ENOTSUPP;

>> +#include <linux/i3c/master.h>

I3C Master API eg: i3c_master_register()

>> +#include <linux/init.h>

Not needed.

>> +#include <linux/interrupt.h>

Interrupt API eg: devm_request_irq().

>> +#include <linux/io.h>
>> +#include <linux/ioport.h>

Used to get io resource.

>> +#include <linux/iopoll.h>
 this function: readl_poll_timeout_atomic().

>> +#include <linux/module.h>

Module API.

>> +#include <linux/platform_device.h>

Platform driver API.

>> +#include <linux/reset.h>

Reset API.

> All of them required? Why?

There is some header files that are already included by others header files.
Should I add them too? it there any rule for that?
Thank for the advice.

>> +       default:
> Just return false here?

Yes, it makes more sense.

>> +               break;
>> +       }
>> +
>> +       return false;
>> +       for (i = 0; i < nbytes; i += 4) {
>> +               u32 data = 0;
>> +
>> +               for (j = 0; j < 4 && (i + j) < nbytes; j++)
>> +                       data |= (u32)bytes[i + j] << (j * 8);
> NIH of get_unaligned_le32()
>
>> +
>> +               writel(data, master->regs + RX_TX_DATA_PORT);
>> +       }
>> +}
>> +
>> +static void dw_i3c_master_read_rx_fifo(struct dw_i3c_master *master,
>> +                                      u8 *bytes, int nbytes)
>> +{
>> +       int i, j;
>> +
>> +       for (i = 0; i < nbytes; i += 4) {
>> +               u32 data;
>> +
>> +               data = readl(master->regs + RX_TX_DATA_PORT);
>> +
>> +               for (j = 0; j < 4 && (i + j) < nbytes; j++)
>> +                       bytes[i + j] = data >> (j * 8);
> Ditto put_unaligned_le32() ?
>
>> +       }
>> +}
> I'm wondering what else you open coded instead of using helpers we already have.

I will see how it works to implement.

>> +               writel(cmd->cmd_hi, master->regs + COMMAND_QUEUE_PORT);
>> +               writel(cmd->cmd_lo, master->regs + COMMAND_QUEUE_PORT);
> hmm... writesl()?

Is there any advantage here?

Probably I can use it to fill the TX buffer with this.

>> +       info->pid = (u64)readl(master->regs + SLV_PID_VALUE);
> Why explicit casting?

info->pid is u64 size.

>
>> +       u32 r;
>> +
>> +
>> +       core_rate = clk_get_rate(master->core_clk);
> Too many blank lines in between.

For me in that way it's better to filter code parts. Do you think that is not
readable?

>> +
>> +
> Ditto.
>
>> +       /* Prepare DAT before launching DAA. */
>> +       for (pos = 0; pos < master->maxdevs; pos++) {
>> +               if (olddevs & BIT(pos))
>> +                       continue;
>> +
>> +               ret = i3c_master_get_free_addr(m, last_addr + 1);
>> +               if (ret < 0)
>> +                       return -ENOSPC;
>> +               master->addrs[pos] = ret;
>> +               p = (ret >> 6) ^ (ret >> 5) ^ (ret >> 4) ^ (ret >> 3) ^
>> +                   (ret >> 2) ^ (ret >> 1) ^ ret ^ 1;
>> +               p = p & 1;
> Is it parity calculus? Do we have something implemented in kernel already?
>
> Btw, https://urldefense.proofpoint.com/v2/url?u=https-3A__graphics.stanford.edu_-7Eseander_bithacks.html-23ParityNaive&d=DwIBaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=qVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=5FpGHBbT8tYA6PB4RT_9O6PJk3v-wYcy1MV59xoqK4I&s=FSJ3EcuoxPtRJWmsk9Yt4s_UH9kxFBam01Xvas2ZFdo&e=
> offered this
>
> v ^= v >> 4;
> v &= 0xf;
> v = (0x6996 >> v) & 1;

I search into the kernel and I didn't find any function for that. In your
opinion what shoud I use?


Thanks for your feedback.

Regards,
Vitor Soares


--------------99CD8D8374B6CE31411AECC4
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Andy,<br>
    </p>
    <br>
    <div class="moz-cite-prefix">Às 4:35 PM de 7/21/2018, Andy
      Shevchenko escreveu:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <pre wrap="">On Fri, Jul 20, 2018 at 11:57 PM, Vitor soares
<a class="moz-txt-link-rfc2396E" href="mailto:Vitor.Soares@synopsys.com">&lt;Vitor.Soares@synopsys.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">This patch add driver for Synopsys DesignWare IP on top of
I3C subsystem patchset proposal V6
</pre>
      </blockquote>
      <pre wrap="">Some of comments below related to style.
But unaligned helpers I think is good to use.

</pre>
      <blockquote type="cite">
        <pre wrap="">+#include &lt;linux/bitops.h&gt;</pre>
      </blockquote>
    </blockquote>
    <br>
    Bit operations API eg: GENMASK...<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+#include &lt;linux/clk.h&gt;</pre>
      </blockquote>
    </blockquote>
    <br>
    Clock API eg: master-&gt;core_clk = devm_clk_get(&amp;pdev-&gt;dev,
    "core_clk");<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+#include &lt;linux/completion.h&gt;</pre>
      </blockquote>
    </blockquote>
    <br>
    Completion API eg: struct completion<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+#include &lt;linux/err.h&gt;</pre>
      </blockquote>
    </blockquote>
    <br>
    Check kernel pointer eg: return PTR_ERR(master-&gt;regs);<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+#include &lt;linux/errno.h&gt;</pre>
      </blockquote>
    </blockquote>
    <br>
    Error codes eg: return -ENOTSUPP;<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+#include &lt;linux/i3c/master.h&gt;</pre>
      </blockquote>
    </blockquote>
    <br>
    I3C Master API eg: i3c_master_register()<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+#include &lt;linux/init.h&gt;</pre>
      </blockquote>
    </blockquote>
    <br>
    Not needed.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+#include &lt;linux/interrupt.h&gt;</pre>
      </blockquote>
    </blockquote>
    <br>
    Interrupt API eg: devm_request_irq().<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+#include &lt;linux/io.h&gt;
+#include &lt;linux/ioport.h&gt;</pre>
      </blockquote>
    </blockquote>
    <br>
    Used to get io resource.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+#include &lt;linux/iopoll.h&gt;</pre>
      </blockquote>
    </blockquote>
     this function: readl_poll_timeout_atomic().<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+#include &lt;linux/module.h&gt;</pre>
      </blockquote>
    </blockquote>
    <br>
    Module API.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+#include &lt;linux/platform_device.h&gt;</pre>
      </blockquote>
    </blockquote>
    <br>
    Platform driver API.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+#include &lt;linux/reset.h&gt;</pre>
      </blockquote>
    </blockquote>
    <br>
    Reset API.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite"> </blockquote>
      <pre wrap="">All of them required? Why?</pre>
    </blockquote>
    <br>
    There is some header files that are already included by others
    header files. Should I add them too? it there any rule for that?<br>
    Thank for the advice.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+       default:
</pre>
      </blockquote>
      <pre wrap="">Just return false here?</pre>
    </blockquote>
    <br>
    Yes, it makes more sense.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+               break;
+       }
+
+       return false;
</pre>
      </blockquote>
      <blockquote type="cite">
        <pre wrap="">+       for (i = 0; i &lt; nbytes; i += 4) {
+               u32 data = 0;
+
</pre>
      </blockquote>
      <blockquote type="cite">
        <pre wrap="">+               for (j = 0; j &lt; 4 &amp;&amp; (i + j) &lt; nbytes; j++)
+                       data |= (u32)bytes[i + j] &lt;&lt; (j * 8);
</pre>
      </blockquote>
      <pre wrap="">NIH of get_unaligned_le32()

</pre>
      <blockquote type="cite">
        <pre wrap="">+
+               writel(data, master-&gt;regs + RX_TX_DATA_PORT);
+       }
+}
+
+static void dw_i3c_master_read_rx_fifo(struct dw_i3c_master *master,
+                                      u8 *bytes, int nbytes)
+{
+       int i, j;
+
+       for (i = 0; i &lt; nbytes; i += 4) {
+               u32 data;
+
+               data = readl(master-&gt;regs + RX_TX_DATA_PORT);
+
</pre>
      </blockquote>
      <blockquote type="cite">
        <pre wrap="">+               for (j = 0; j &lt; 4 &amp;&amp; (i + j) &lt; nbytes; j++)
+                       bytes[i + j] = data &gt;&gt; (j * 8);
</pre>
      </blockquote>
      <pre wrap="">Ditto put_unaligned_le32() ?

</pre>
      <blockquote type="cite">
        <pre wrap="">+       }
+}
</pre>
      </blockquote>
      <pre wrap="">I'm wondering what else you open coded instead of using helpers we already have.</pre>
    </blockquote>
    <br>
    I will see how it works to implement.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+               writel(cmd-&gt;cmd_hi, master-&gt;regs + COMMAND_QUEUE_PORT);
+               writel(cmd-&gt;cmd_lo, master-&gt;regs + COMMAND_QUEUE_PORT);
</pre>
      </blockquote>
      <pre wrap="">hmm... writesl()?</pre>
    </blockquote>
    <br>
    Is there any advantage here?<br>
    <br>
    Probably I can use it to fill the TX buffer with this.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="">+       info-&gt;pid = (u64)readl(master-&gt;regs + SLV_PID_VALUE);
</pre>
      </blockquote>
      <pre wrap="">Why explicit casting?</pre>
    </blockquote>
    <br>
    info-&gt;pid is u64 size.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">+       u32 r;
+
+
+       core_rate = clk_get_rate(master-&gt;core_clk);
</pre>
      </blockquote>
      <pre wrap="">Too many blank lines in between.</pre>
    </blockquote>
    <br>
    For me in that way it's better to filter code parts. Do you think
    that is not readable? <br>
    <br>
    <blockquote type="cite"
cite="mid:CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">+
+
</pre>
      </blockquote>
      <pre wrap="">Ditto.

</pre>
      <blockquote type="cite">
        <pre wrap="">+       /* Prepare DAT before launching DAA. */
+       for (pos = 0; pos &lt; master-&gt;maxdevs; pos++) {
+               if (olddevs &amp; BIT(pos))
+                       continue;
+
+               ret = i3c_master_get_free_addr(m, last_addr + 1);
+               if (ret &lt; 0)
+                       return -ENOSPC;
+               master-&gt;addrs[pos] = ret;
</pre>
      </blockquote>
      <blockquote type="cite">
        <pre wrap="">+               p = (ret &gt;&gt; 6) ^ (ret &gt;&gt; 5) ^ (ret &gt;&gt; 4) ^ (ret &gt;&gt; 3) ^
+                   (ret &gt;&gt; 2) ^ (ret &gt;&gt; 1) ^ ret ^ 1;
+               p = p &amp; 1;
</pre>
      </blockquote>
      <pre wrap="">Is it parity calculus? Do we have something implemented in kernel already?

Btw, <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__graphics.stanford.edu_-7Eseander_bithacks.html-23ParityNaive&amp;d=DwIBaQ&amp;c=DPL6_X_6JkXFx7AXWqB0tg&amp;r=qVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&amp;m=5FpGHBbT8tYA6PB4RT_9O6PJk3v-wYcy1MV59xoqK4I&amp;s=FSJ3EcuoxPtRJWmsk9Yt4s_UH9kxFBam01Xvas2ZFdo&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__graphics.stanford.edu_-7Eseander_bithacks.html-23ParityNaive&amp;d=DwIBaQ&amp;c=DPL6_X_6JkXFx7AXWqB0tg&amp;r=qVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&amp;m=5FpGHBbT8tYA6PB4RT_9O6PJk3v-wYcy1MV59xoqK4I&amp;s=FSJ3EcuoxPtRJWmsk9Yt4s_UH9kxFBam01Xvas2ZFdo&amp;e=</a>
offered this

v ^= v &gt;&gt; 4;
v &amp;= 0xf;
v = (0x6996 &gt;&gt; v) &amp; 1;</pre>
    </blockquote>
    <br>
    I search into the kernel and I didn't find any function for that. In
    your opinion what shoud I use?<br>
    <br>
    <br>
    Thanks for your feedback.<br>
    <br>
    Regards,<br>
    Vitor Soares<br>
    <br>
  </body>
</html>

--------------99CD8D8374B6CE31411AECC4--

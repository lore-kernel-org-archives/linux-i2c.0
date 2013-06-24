From: arno@natisbad.org (Arnaud Ebalard)
Subject: Re: [BUG] mv64xxx i2c bus lock w/ commit eda6bee6c7
Date: Mon, 24 Jun 2013 23:31:28 +0200
Message-ID: <87wqpjkxfz.fsf@natisbad.org>
References: <87a9mkttxr.fsf@natisbad.org> <20130623153931.GD7626@kw.sim.vm.gnt>
 <20130623160659.GB17536@roeck-us.net> <87fvw8ehne.fsf@natisbad.org>
 <20130624183006.GA3129@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130624183006.GA3129@katana> (Wolfram Sang's message of "Mon,
 24 Jun 2013 20:30:07 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Andrew Lunn <andrew@lunn.ch>, Simon Guinot <simon.guinot@sequanux.org>, "Mark A. Greer" <mgreer@mvista.com>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Rodolfo Giometti <giometti@linux.it>, Mauro Barella <mbarella@vds-it.com>, Guenter Roeck <linux@roeck-us.net>, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-i2c@vger.kernel.org

Hi,

Wolfram Sang <wsa@the-dreams.de> writes:

>> does nothing fancy either. While debugging I ended up on Debian bug
>> #622325 (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=622325) which
>> made the driver a little less suspect when a revert of commit eda6bee6c7
>> fixed the issue for me.
>
> Either wait for 3.11 or pick 4243fa0bad551b8c8d4ff7104e8fd557ae848845
> "(I2C: mv64xxx: fix race between FSM/interrupt and process context")
> from my for-next branch. (Note the other patches from Russell, probably
> all worth to pick).

Thanks for the tip. Will try it tomorrow.

> Would be nice if you could pass the info to the Debian bug as well.

I will.

Cheers,

a+

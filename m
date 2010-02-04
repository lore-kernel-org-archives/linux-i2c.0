From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/1] fix i2c_msg.len not aligning with i2c_master_send
Date: Thu, 4 Feb 2010 04:47:41 -0800
Message-ID: <f17812d71002040447y4b6f889o1137ae6149559994@mail.gmail.com>
References: <309424b61002032204y37307236q94ab3a502b0526e0@mail.gmail.com>
	<20100204103530.65429c04@hyperion.delvare>
	<309424b61002040438i2fae055dt2d3ef528eae99b48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <309424b61002040438i2fae055dt2d3ef528eae99b48@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, haojian.zhuang@marvell.com, linux-arm-kernel@lists.infradead.org, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

> How about return error in i2c_master_send & i2c_master_recv when count
> is bigger than 64K, as suggested by Ben.

I think that's more preferable. Making the count parameter as u16,
though is going to generate a warning, yet that's usually ignored
by careless programmer, screaming out when this happens might
be more useful sometimes.

> The device I used could receive 32K one time instead, the firmware
> download only takes place on-demand in fact.
> However, it took some time to debug, since no error info come out.
> Add error msg may notify users, though transfering more than 64K data
> one time is rarely happen.
>
> Thanks
> Zhangfei
>

From: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: Re: [PATCH v3 REPOST 3/4] i2c: i2c-ibm-iic: Implements transfer
 abortion
Date: Fri, 3 Jan 2014 17:14:32 +0100
Message-ID: <CACh+v5NZWW=y377_-B7tpDCMzbnNMhz4vT1EhuRZhnj3oxBjxg@mail.gmail.com>
References: <1387552376-12986-1-git-send-email-jjhiblot@traphandler.com>
 <1387552376-12986-4-git-send-email-jjhiblot@traphandler.com>
 <20140103150948.GB7132@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20140103150948.GB7132@katana>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linuxppc-dev@lists.ozlabs.org, jean-jacques hiblot <jjhiblot@traphandler.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

2014/1/3 Wolfram Sang <wsa@the-dreams.de>:
> On Fri, Dec 20, 2013 at 04:12:55PM +0100, jean-jacques hiblot wrote:
>> From: jean-jacques hiblot <jjhiblot@gmail.com>
>>
>> Clean-up properly when a transfer fails for whatever reason.
>> Cancel the transfer when the process is signaled.
>
> Please describe what you do a little. I wonder how you can remove so
> much code while keeping the functionality?

Well there are 2 reasons why so much code went away.
1) The iic_wait_for_tc() function wasn't used anymore (it should have
disappeared in an earlier patch but the diff was terrible to read)
2) the whole abortion scheme is different. It's now done as a part of
the data transfer. The reason is that the controller doesn't react
properly to abortion when it's not done at the right moment.
The idea here is to abort the transfer right after sending the next
byte to keep the controller happy. If the abortion is asked at the
wrong moment, the controller may not set the abortion complete flag
and the next transfer may fail.


>
>>
>> Signed-off-by: jean-jacques hiblot <jjhiblot@traphandler.com>
>
>> -     out_8(&iic->cntl, CNTL_HMT);
>> +     DBG(dev, "aborting transfer\n");
>> +     /* transfer should be aborted within 10ms */
>> +     end = jiffies + 10;
>
> Eeks, msecs_to_jiffies() macro please!
>
> And please consider running checkpatch and sparse over your code. Sparse
> gives, for example:
>
> drivers/i2c/busses/i2c-ibm_iic.c:418:24: warning: incorrect type in argument 1 (different address spaces)
> drivers/i2c/busses/i2c-ibm_iic.c:418:24:    expected unsigned char const volatile [noderef] [usertype] <asn:2>*addr
> drivers/i2c/busses/i2c-ibm_iic.c:418:24:    got unsigned char *<noident>
>
> (This probably due to patch 1 or 2, I'd guess)
>

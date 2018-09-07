From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] i2c: xiic: Record xilinx i2c with Zynq fragment
Date: Fri, 7 Sep 2018 12:57:41 +0200
Message-ID: <cb141649-98a8-3019-a869-485b78f04f66@xilinx.com>
References: <a36257084b0816bd84bb1caacdcde586b7fcb007.1536300108.git.michal.simek@xilinx.com>
 <20180907103407.GA2310@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907103407.GA2310@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, linux-i2c@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Heiko Schocher <hs@denx.de>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, u-boot@lists.denx.de, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-i2c@vger.kernel.org

On 7.9.2018 12:34, Wolfram Sang wrote:
> On Fri, Sep 07, 2018 at 08:02:05AM +0200, Michal Simek wrote:
>> Include xilinx soft i2c controller to Zynq fragment to make clear who is
>> responsible for it.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> Cool, thanks!
> 
>> ---
>>
>> Normally we are handling all these drivers via one fragment to make sure
>> that there is only one central contact. Another reason is that people are
>> changing and their responsibility is moving time to time.
> 
> This is fine with me, but what about sorting the entries? I don't care
> much because it is "your" entry, yet I thought I mention it. Let me know
> if I should apply this as-is nonetheless.

It is not sorted even now that's why not big deal. I can sort it later
with this included.

Thanks,
Michal

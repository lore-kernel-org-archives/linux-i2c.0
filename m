From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] i2c-rcar: fix RCAR_IRQ_ACK_{RECV|SEND}
Date: Sun, 21 Sep 2014 21:39:39 +0400
Message-ID: <541F0D5B.5060707@cogentembedded.com>
References: <2641177.jdYX8POT82@wasted.cogentembedded.com> <20140920095130.GK1612@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140920095130.GK1612@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello.

On 09/20/2014 01:51 PM, Wolfram Sang wrote:

>> Bits 8-31 of all registers reflect the value of bits 0-7 on reads and should be
>> 0 on writes, according to the manuals. RCAR_IRQ_ACK_{RECV|SEND} macros have all
>> 1's in bits 8-31, thus going against the manuals, so fix them.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Cc: stable@vger.kernel.org

> Applied to for-current, thanks!

    Thanks. However, I don't see it in your tree (and neither my cleanups).

WBR, Sergei


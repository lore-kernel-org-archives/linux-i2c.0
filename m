From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2] i2c: bcm2835: Clear current buffer pointers and counts
 after a transfer
Date: Tue, 5 Feb 2019 15:14:36 +0100
Message-ID: <3784fe11-bdc4-5751-13b4-f50bdeeee205@i2se.com>
References: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
 <20190205120905.GB1045@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205120905.GB1045@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Eben Upton <eben@raspberrypi.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Am 05.02.19 um 13:09 schrieb Wolfram Sang:
> On Thu, Dec 27, 2018 at 04:42:25PM +0100, Paul Kocialkowski wrote:
>> The driver's interrupt handler checks whether a message is currently
>> being handled with the curr_msg pointer. When it is NULL, the interrupt
>> is considered to be unexpected. Similarly, the i2c_start_transfer
>> routine checks for the remaining number of messages to handle in
>> num_msgs.
>>
>> However, these values are never cleared and always keep the message and
>> number relevant to the latest transfer (which might be done already and
>> the underlying message memory might have been freed).
>>
>> When an unexpected interrupt hits with the DONE bit set, the isr will
>> then try to access the flags field of the curr_msg structure, leading
>> to a fatal page fault.
>>
>> The msg_buf and msg_buf_remaining fields are also never cleared at the
>> end of the transfer, which can lead to similar pitfalls.
>>
>> Fix these issues by introducing a cleanup function and always calling
>> it after a transfer is finished.
>>
>> Fixes: e2474541032d ("i2c: bcm2835: Fix hang for writing messages larger than 16 bytes")
>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Stefan, Florian, any comment about this patch?

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks

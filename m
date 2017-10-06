From: Stephen Douthit <stephend@adiengineering.com>
Subject: Re: [PATCH] i2c: ismt: Separate I2C block read from SMBus block read
Date: Fri, 6 Oct 2017 18:54:56 -0400
Message-ID: <9e4c9318-579f-b5f2-6ad2-c1cb9aad8e78@adiengineering.com>
References: <20171002124519.GA13496@leonis.localdomain>
 <20171005124133.7ue727bib2mlpnyy@ninjato>
 <20171005141311.GA8565@leonis.localdomain>
Reply-To: stephend@adiengineering.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0091.outbound.protection.outlook.com ([104.47.1.91]:57067
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751868AbdJFWzP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 6 Oct 2017 18:55:15 -0400
In-Reply-To: <20171005141311.GA8565@leonis.localdomain>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pontus Andersson <epontan@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/05/2017 10:13 AM, Pontus Andersson wrote:
> On Thu, Oct 05, 2017 at 02:41:33PM +0200, Wolfram Sang wrote:
>> On Mon, Oct 02, 2017 at 02:45:19PM +0200, Pontus Andersson wrote:
>>> Commit b6c159a9cb69 ("i2c: ismt: Don't duplicate the receive length for
>>> block reads") broke I2C block reads. It aimed to fix normal SMBus block
>>> read, but changed the correct behavior of I2C block read in the process.
>>>
>>> According to Documentation/i2c/smbus-protocol, one vital difference
>>> between normal SMBus block read and I2C block read is that there is no
>>> byte count prefixed in the data sent on the wire:
>>>
>>>   SMBus Block Read:  i2c_smbus_read_block_data()
>>>   S Addr Wr [A] Comm [A]
>>>              S Addr Rd [A] [Count] A [Data] A [Data] A ... A [Data] NA P
>>>
>>>   I2C Block Read:  i2c_smbus_read_i2c_block_data()
>>>   S Addr Wr [A] Comm [A]
>>>              S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P
>>>
>>> Therefore the two transaction types need to be processed differently in
>>> the driver by copying of the dma_buffer as done previously for the
>>> I2C_SMBUS_I2C_BLOCK_DATA case.
>>>
>>> Fixes: b6c159a9cb69 ("i2c: ismt: Don't duplicate the receive length for block reads")
>>> Signed-off-by: Pontus Andersson <epontan@gmail.com>
>>> Cc: stable@vger.kernel.org
>>
>> Applied to for-current, thanks!
> 
> Thank you! Is it safe to asume it will be backported to 4.4 stable
> branch and upwards as the problematic commit did (once in mainline)?
> 
>> Might have been good to CC the patch author of the problematic commit,
>> too.
> 
> Yes, of course! Stephen is CC now at least (kept the commit message
> quoted at his convenience).

Doh.  Looks like our regression test gave a false pass on the I2C access 
case.  I'd guess it's probably doing a series of byte reads instead of a 
block read and missing the I2C_SMBUS_I2C_BLOCK_DATA case entirely.

Unfortunately I can't find the board that was modded with more I2C 
devices on the ismt bus to verify this right now.  I'll check with Dan 
on Monday to see if he knows where that board is stashed.

Apologies for moving the bug instead of fixing it, and FWIW I'll have an 
update Monday.

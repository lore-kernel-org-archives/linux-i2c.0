From: "Frkuska, Joshua" <joshua_frkuska@mentor.com>
Subject: Re: [[RFC V3] 1/1] i2c: imx: add slave support
Date: Thu, 15 Dec 2016 09:42:08 +0900
Message-ID: <37b90839-1502-07d9-e6e5-593c840ef3b5@mentor.com>
References: <1481695291-11444-1-git-send-email-joshua_frkuska@mentor.com>
 <1481695291-11444-2-git-send-email-joshua_frkuska@mentor.com>
 <20161214133639.GA1476@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:47524 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbcLOAmS (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Dec 2016 19:42:18 -0500
In-Reply-To: <20161214133639.GA1476@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, syrchin@dev.rtsoft.ru, peda@axentia.se, vladimir_zapolskiy@mentor.com, Jiada_Wang@mentor.com

Hello Wolfram,

Please see inline. Thank you

On 12/14/2016 10:36 PM, Wolfram Sang wrote:
> On Wed, Dec 14, 2016 at 03:01:31PM +0900, Joshua Frkuska wrote:
>> Add I2C slave provider using the generic slave interface.
>> It also supports master transactions when the slave in the idle mode.
>
> I am confused. In the cover letter you write "Furthermore the state
> machine introduced to handle the slave states does not handle the master
> mode behavior." Yet here you say it supports master transactions? Is the
> sentence from the cover letter outdated?

The cover letter is not outdated but does not elaborate enough. The 
state machine (slave task) operates when I2C_SLAVE is enabled and a 
slave device registered. The slave state machine keeps track of the 
master state but only has two roles relating to master mode. The first 
is to stop the controller when imx_stop is called. The second is to 
transition from an idle state to master mode via a START event. This 
puts the hardware in a possible transition state where the IBB status 
flag hasn't been set yet. To avoid this, the transition 'SP' 
intermediate state is created and we wait for the IBB flag to raise or 
time out after a number of attempts. All other hardware control in 
master mode is done via the i2c_imx_xfer, i2c_imx_start/stop functions. 
When I2C_SLAVE is disabled, the above state machine is not active and 
does serve the STOP event nor does it poll on IBB in this transition 
period. I hope this answers your questions.

>
> Regards,
>
>    Wolfram
>

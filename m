From: Matthew Weber <matthew.weber@rockwellcollins.com>
Subject: Re: [PATCH 1/1] i2c: cadance: (bugfix) ctrl/addr reg write order
Date: Thu, 22 Jun 2017 06:34:02 -0500
Message-ID: <CANQCQpbmhfD0jgW2bQm6hjR_CTJiPHbNE_jfU9uicH7PVd6xjg@mail.gmail.com>
References: <1498095926-51264-1-git-send-email-matthew.weber@rockwellcollins.com>
 <20170622083546.33glkhns4hlodrbe@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from secvs02.rockwellcollins.com ([205.175.225.241]:10611 "EHLO
        secvs02.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750812AbdFVLeF (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 22 Jun 2017 07:34:05 -0400
Received: by mail-yb0-f200.google.com with SMTP id e186so9030503ybb.0
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jun 2017 04:34:04 -0700 (PDT)
In-Reply-To: <20170622083546.33glkhns4hlodrbe@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, soren.brinkmann@xilinx.com, John Linn <john.linn@xilinx.com>, Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>

Wolfram,

On Thu, Jun 22, 2017 at 3:35 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Wed, Jun 21, 2017 at 08:45:26PM -0500, Matt Weber wrote:
>> The driver was clearing the hold bit in the control register before
>> writing to the address register which resulted in a stop condition
>> being generated rather than a repeated start.
>>
>> This issue was only observed when a system was running much
>> slower than a normal processor would execute.  The IP data sheet
>> mentions a ordering of writing to the address register before
>> clearing the hold.
>>
>> Signed-off-by: John Linn <john.linn@xilinx.com>
>> Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
>> Signed-off-by: Matthew Weber <matthew.weber@rockwellcollins.com>
>
> Looks good. It seems not urgent to me, though. Are you fine with me
> scheduling it for 4.13 yet with a stable tag attached? Or do you
> consider it 4.12 material? And if you could provide a Fixes: tag that
> would be helpful.
>

Not urgent, fell free to work it in where it makes sense. We're on a
older LTS at this point and will carry the patch.

For the Fixes: tag in this case, should I just prefix my last
statement about the issue as there isn't a public bug report or
specific commit I can note?  I could add cadence ref manual section
and a link to a public download of the doc.

Matt

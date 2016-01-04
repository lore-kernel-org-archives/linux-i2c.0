From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH 10/10] i2c: pca954x: get rid of the i2c deadlock workaround
Date: Mon, 04 Jan 2016 16:45:36 +0100
Message-ID: <568A93A0.5030109@lysator.liu.se>
References: <1451920215-29167-1-git-send-email-peda@lysator.liu.se> <1451920215-29167-11-git-send-email-peda@lysator.liu.se> <568A8D87.8020201@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <568A8D87.8020201@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2016-01-04 16:19, Lars-Peter Clausen wrote:
> On 01/04/2016 04:10 PM, Peter Rosin wrote:
>> From: Peter Rosin <peda@axentia.se>
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> It would be quite good if the commit messaged said why it is now safe to
> remove the workaround.

Right, hmm, the two last patches seemed obvious at the time I wrote them,
but now I see a problem.

E.g. if two pca954x devices that depends on being idle when client devices
are not accessed happen to sit on the same bus (perhaps because the muxes
are used to hide a bunch of identical devices), it is indeed not safe to
make this change.

Thanks for making my think, and consider 9/10 and 10/10 dropped.

Cheers,
Peter

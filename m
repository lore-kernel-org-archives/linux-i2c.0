From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH v6 19/24] i2c-mux: document i2c muxes and elaborate on
 parent-/mux-locked muxes
Date: Tue, 05 Apr 2016 09:50:32 +0200
Message-ID: <57036E48.9080404@lysator.liu.se>
References: <1459673574-11440-1-git-send-email-peda@lysator.liu.se> <1459673574-11440-20-git-send-email-peda@lysator.liu.se> <5700F9DA.1040501@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5700F9DA.1040501@kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Antti Palosaari <crope@iki.fi>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Kalle Valo <kvalo@codeaurora.org>, Joe Perches <joe@perches.com>, Jiri Slaby <jslaby@suse.com>, Daniel Baluta <daniel.baluta@intel.com>, Adriana Reus <adriana.reus@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Matt Ranostay <matt.ranostay@intel.com>
List-Id: linux-i2c@vger.kernel.org

On 2016-04-03 13:09, Jonathan Cameron wrote:
> On 03/04/16 09:52, Peter Rosin wrote:
>> From: Peter Rosin <peda@axentia.se>
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> Very nice, one typo that I could see.

Thanks!

*snip*

>> +     and the actual transfer (e.g. if the child mux is auto-closing
>> +     and the parent mux issus i2c-transfers as part of its select).
>> +     This is especailly the case if the parent mux is mux-locked, but
> especially

Fixed now in my local repo.

Cheers,
Peter

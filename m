From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 14/24] of/unittest: convert to use an explicit i2c mux
 core
Date: Mon, 4 Apr 2016 00:16:28 -0500
Message-ID: <20160404051628.GO17806@rob-hp-laptop>
References: <1459673574-11440-1-git-send-email-peda@lysator.liu.se>
 <1459673574-11440-15-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459673574-11440-15-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@lysator.liu.se>
Cc: linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Antti Palosaari <crope@iki.fi>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Kalle Valo <kvalo@codeaurora.org>, Joe Perches <joe@perches.com>, Jiri Slaby <jslaby@suse.com>, Daniel Baluta <daniel.baluta@intel.com>, Adriana Reus <adriana.reus@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Matt
List-Id: linux-i2c@vger.kernel.org

On Sun, Apr 03, 2016 at 10:52:44AM +0200, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> Allocate an explicit i2c mux core to handle parent and child adapters
> etc. Update the select op to be in terms of the i2c mux core instead
> of the child adapter.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/of/unittest.c | 40 +++++++++++++++-------------------------
>  1 file changed, 15 insertions(+), 25 deletions(-)

I assume you ran the unittest...

Acked-by: Rob Herring <robh@kernel.org>

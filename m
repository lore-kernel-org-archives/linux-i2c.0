From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 10/10] i2c: pca954x: get rid of the i2c deadlock
 workaround
Date: Mon, 4 Jan 2016 16:19:35 +0100
Message-ID: <568A8D87.8020201@metafoo.de>
References: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
 <1451920215-29167-11-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451920215-29167-11-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@lysator.liu.se>, Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 01/04/2016 04:10 PM, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

It would be quite good if the commit messaged said why it is now safe to
remove the workaround.

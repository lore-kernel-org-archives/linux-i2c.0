From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 0/2] check I2C device id for pca984x chips
Date: Sat, 10 Mar 2018 01:05:43 +0100
Message-ID: <7fdb753f-2330-e93c-bbe3-e59fd96a253d@axentia.se>
References: <20180305205822.951-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305205822.951-1-peda@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Adrian Fiergolski <adrian.fiergolski@cern.ch>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-03-05 21:58, Peter Rosin wrote:
> Hi!
> 
> This series tries to check the I2C device id, but instead of open
> coding the check in the pca954x driver, I have a new function in
> the core doing the work.
> 
> Changes since v1:
> - Added Tested-by tag from Adrian
> - Added Reviewed-by tag from Wolfram
> - Replaced client->flags with a zero in the i2c_smbus_xfer call
> 
> Wolfram: I'll send a pull with the first patch in a few days, to
> allow for a second round of feedback now that the RFC marker is gone.

Both patches pushed to i2c-mux/for-next.

Cheers,
Peter

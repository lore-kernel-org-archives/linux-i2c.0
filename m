From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 1/8 v3] i2c: i801: refactor use of LAST_BYTE
 i801_block_transaction_byte_by_byte
Date: Wed, 27 Jun 2012 16:39:29 +0200
Message-ID: <20120627163929.4305eaa7@endymion.delvare>
References: <1340805255-8041-1-git-send-email-djkurtz@chromium.org>
	<1340805255-8041-2-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340805255-8041-2-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Seth Heasley <seth.heasley@intel.com>, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 27 Jun 2012 21:54:08 +0800, Daniel Kurtz wrote:
> As a slight optimization, pull some logic out of the polling loop during
> byte-by-byte transactions by just setting the I801_LAST_BYTE bit, as
> defined in the i801 (PCH) datasheet, when reading the last byte of a
> byte-by-byte I2C_SMBUS_READ.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  drivers/i2c/busses/i2c-i801.c |   28 ++++++++++++++--------------
>  1 files changed, 14 insertions(+), 14 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare

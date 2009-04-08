From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v3 4/5] powerpc: i2c-mpc: document new FSL I2C bindings and cleanup
Date: Wed, 8 Apr 2009 00:13:36 -0500
Message-ID: <FD9A70C0-D4D0-4867-B1C1-3D6CFC5C0E93@kernel.crashing.org>
References: <20090407082052.477328750@denx.de> <20090407082231.646648985@denx.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090407082231.646648985-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


On Apr 7, 2009, at 3:20 AM, Wolfgang Grandegger wrote:

> This patch documents the new bindings for the MPC I2C bus driver.
> Furthermore, it removes obsolete FSL device related definitions
> for I2C.
> It should go through the appropriate PowerPC maintainer(s) hands.
>
> Signed-off-by: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
> ---
> Documentation/powerpc/dts-bindings/fsl/i2c.txt |   46 +++++++++++++++ 
> +---------
> include/linux/fsl_devices.h                    |    4 --
> 2 files changed, 31 insertions(+), 19 deletions(-)

applied to merge

- k

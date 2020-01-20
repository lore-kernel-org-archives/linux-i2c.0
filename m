From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 01/26] docs: i2c: sort index logically
Date: Mon, 20 Jan 2020 10:08:50 +0100
Message-ID: <20200120100850.001e032b@endymion>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
        <20200105225012.11701-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200105225012.11701-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Luca,

On Sun,  5 Jan 2020 23:49:47 +0100, Luca Ceresoli wrote:
> The index page currently lists sections in alphabetical file order without
> caring about their content. Sort sections based on their content logically,
> according to the following structure:
> 
>  * Intro to I2C/SMBus and their usage in Linux: summary, i2c-protocol,
>    smbus-protocol, instantiating-devices, busses/index, i2c-topology,
>    muxes/i2c-mux-gpio
>  * Implementing drivers: writing-clients, dev-interface,
>    dma-considerations, fault-codes, functionality
>  * Debugging: gpio-fault-injection, i2c-stub
>  * Slave I2C: slave-interface, slave-eeprom-backend
>  * Advanced: ten-bit-addresses
>  * Obsolete info: upgrading-clients, old-module-parameters

Good idea. I wonder, would there be a way to materialize these group
names in the documentation itself? I found it useful when reviewing the
patch, but in the long term it would be even more useful if the end
readers would see them too.

> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  Documentation/i2c/index.rst | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/i2c/index.rst b/Documentation/i2c/index.rst
> index a0fbaf6d0675..bd0ff9d00793 100644
> --- a/Documentation/i2c/index.rst
> +++ b/Documentation/i2c/index.rst
> @@ -7,27 +7,26 @@ I2C/SMBus Subsystem
>  .. toctree::
>     :maxdepth: 1
>  
> +   summary
> +   i2c-protocol
> +   smbus-protocol
> +   instantiating-devices
> +   busses/index
> +   i2c-topology
> +   muxes/i2c-mux-gpio
> +   writing-clients
>     dev-interface
>     dma-considerations
>     fault-codes
>     functionality
>     gpio-fault-injection
> -   i2c-protocol
>     i2c-stub
> -   i2c-topology
> -   instantiating-devices
> -   old-module-parameters
> -   slave-eeprom-backend
>     slave-interface
> -   smbus-protocol
> -   summary
> +   slave-eeprom-backend
>     ten-bit-addresses
>     upgrading-clients
> -   writing-clients
> -
> -   muxes/i2c-mux-gpio
> +   old-module-parameters
>  
> -   busses/index
>  

You end up with 2 blank lines in a row here, ideally there should be
only one left.

>  .. only::  subproject and html
>  

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

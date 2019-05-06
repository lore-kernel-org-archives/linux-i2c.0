From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 2/2] eeprom: ee1004: Deal with nack on page selection
Date: Mon, 6 May 2019 17:03:20 +0300
Message-ID: <04843f27-bb0f-d631-32c8-80cd122b7399@linux.intel.com>
References: <20190506151539.69ee75e8@endymion>
 <20190506151656.47494e56@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190506151656.47494e56@endymion>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-i2c@vger.kernel.org

On 5/6/19 4:16 PM, Jean Delvare wrote:
> Some EE1004 implementations will not properly ack page selection
> commands. They still set the page correctly, so there is no actual
> error. Deal with this case gracefully by checking the currently
> selected page after we receive a nack. If the page is set right then
> we can continue.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/misc/eeprom/ee1004.c |   12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
Does Dreamcat4 deserve reported and tested by tags here? I guess 
anonymous address is fine with those tags?

(I re-tested these two patches on top of v5.1 and they make decode-dimms 
working on a machine with 2-4 * Crucial DD4 dimms)

-- 
Jarkko

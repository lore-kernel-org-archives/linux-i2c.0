From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Simple read byte data compilation problem
Date: Tue, 21 Oct 2008 14:59:56 +0200
Message-ID: <20081021145956.4a65467e@hyperion.delvare>
References: <ce62e9d00810210244p3194a50fj3b6b19209465ac7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <ce62e9d00810210244p3194a50fj3b6b19209465ac7e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Fabien Marteau <fabien.marteau-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Salut Fabien,

On Tue, 21 Oct 2008 11:44:28 +0200, Fabien Marteau wrote:
> I wrote a simple user program to test an i2c bus driver. I found in
> Documentation/i2c/dev-interface their is macro function to read data
> (i2c_smbus_read_byte_data). I used it but I have link error when I compile :
> $ arm-linux-gcc -O i2cread.c -o i2cread
> /tmp/ccfa90st.o: In function `read_byte':
> i2cread.c:(.text+0x3c): undefined reference to `i2c_smbus_read_byte_data'
> collect2: ld returned 1 exit status
> 
> Is someone know what is the problem ?

Documentation/i2c/dev-interface says:

So let's say you want to access an i2c adapter from a C program. The
first thing to do is "#include <linux/i2c-dev.h>". Please note that
there are two files named "i2c-dev.h" out there, one is distributed
with the Linux kernel and is meant to be included from kernel
driver code, the other one is distributed with i2c-tools and is
meant to be included from user-space programs. You obviously want
the second one here.

Apparently you missed this paragraph.

As a side note, if you only need to test your bus driver, the
i2cdetect, i2cget, i2cset and i2cdump utilities from the i2c-tools
package should be a good start, maybe you don't need to write your own
utility.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

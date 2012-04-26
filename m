From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Query : NACK
Date: Thu, 26 Apr 2012 20:35:41 +0530
Message-ID: <CAM=Q2ctSebbq=XhrZyOuWzEpo5MSbZF2uVH=wwLywnT_HQ+mrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

Currently the i2c

</snippet>

 * Returns negative errno, else the number of messages executed.
 *
 * Note that there is no requirement that each message be sent to
 * the same slave address, although that is the most common model.
 */
int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
{
        unsigned long orig_jiffies;
        int ret, try;

        /* REVISIT the fault reporting model here is weak:
         *
         *  - When we get an error after receiving N bytes from a slave,
         *    there is no way to report "N".
         *
         *  - When we get a NAK after transmitting N bytes to a slave,
         *    there is no way to report "N" ... or to let the master
         *    continue executing the rest of this combined message, if
         *    that's the appropriate response.
         *
         *  - When for example "num" is two and we successfully complete
         *    the first message but get an error part way through the
         *    second, it's unclear whether that should be reported as
         *    one (discarding status on the second message) or errno
         *    (discarding status on the first one).
         */
</end>

Some of the  drivers expect to get the no of bytes transmitted on NACK
so that they can
re-transmit the remaining bytes.

I did a quick search and didnt find a patch that currently targets to
resend the number of bytes.
In case I missed a discussion  please feel free to point.

Will it be acceptable solution if
if (ret == NOERR)
   return  count
if (ret == NACKERR)
     return  no_of_bytes;
else
     return  ret;

Or are there better suggestions to achieve it by _not_changing existing drivers.

Thanks and Regards,
Shubhro

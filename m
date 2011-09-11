From: Henri Kjellberg <henrikjellberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: I2C Combined Transactions in Linux
Date: Sun, 11 Sep 2011 10:52:53 -0500
Message-ID: <CAFfjFp2Gi3tXbwcHB--n+DN61em3mer36Xg_mPFP-=uVihHkLg@mail.gmail.com>
References: <CAFfjFp1KAmr2w=0Nwt1FtvYSNb7CJ59AHJtXmnnpat-PdyvHzA@mail.gmail.com>
	<20110911145905.65659433@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110911145905.65659433-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Sun, Sep 11, 2011 at 7:59 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Henri,
>
> On Sat, 10 Sep 2011 14:45:37 -0500, Henri Kjellberg wrote:
>> Greetings Friends,
>> I am looking for a way to perform combined transactions over I2C in
>> Linux. The structure of the message I need to send is as follows. The
>> slave responds in the brackets.
>>
>> START
>> Slave Address, Write
>> [ACK]
>> Data
>> [ACK]
>> Data
>> [ACK]
>> ...
>> FEND
>
> Without a [ACK] or [NACK] here, your transaction is not valid I2C. Is
> it really not there, or did you omit to mention it?
>

You are correct, I accidentally omitted the [ACK]

>> START
>
> Plain Start cannot happen in the middle of a transaction. Did you mean
> Repeated Start?
>

This should be indeed a repeated start.

>> Slave Address, Write
>> [Data]
>> ACK
>> [Data]
>> ACK
>> ...
>> [FEND]
>> ACK
>> STOP
>>
>> Here, FEND is a special end of message byte defined in a manner
>> similar to the SLIP encapsulation. It does not appear that I can use
>
> I have no idea what "SLIP encapsulation" is. Can you just explain what
> FEND is without external references? Is it simply a special byte value
> which means the end of the message?
>

FEND is a special byte that is guaranteed to occur no where else in
the message. It indicates the end of the message. So, when the device
I am attempting to communicate with sees the FEND byte, it knows that
it will next be asked to send data to the master. At the end of the
slave's message, it will send a FEND as well indicating to the Master
that the message is over. This particular form of it is also used in
AX.25.

>> the i2c_smbus_block_process_call because it requires the first data
>> byte to be the message length. Is there any way to send these sorts of
>> combined transaction in Linux without using the smbus interface?
>
> The above doesn't look like any standard SMBus transaction, as you
> found out, so there is no way to achieve it with i2c_smbus_*(). If it
> can be done, that would be with i2c_transfer() (in the kernel) or
> ioctl(I2C_RDWR) (from user-space).
>
> But even that may not be doable with the current infrastructure, if
> FEND can happen at any point of the transaction and thus the initial
> length of the transaction is unknown.
>

What I have been trying to figure out is what parts of the kernel code
could I modify in order to be able to perform this sort of message.
The major difference here is that I don't know the exact return
message length. Is there some subtle fundamental barrier that prevents
me from implementing something like this within Linux? I have been
looking at the code in drivers/i2c/i2c-pnx.c trying to understand what
I could use as a starting point and what I could modify to extract the
desired behavior. Any guidance or further requests for clarification
are welcome!

Kind Regards,
Henri

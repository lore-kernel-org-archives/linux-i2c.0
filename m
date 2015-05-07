From: os user <gnusercn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Regarding to force bus id for channels of pca954x
Date: Thu, 7 May 2015 10:47:23 +0800
Message-ID: <CAG+qjJ93vvEpSC+_XHW-yaKgbecR22JikdOyHzU5Ev9eHxck_w@mail.gmail.com>
References: <CAG+qjJ8qEjzNkjxmUh8yng-Fcxm=_PjteoGqw38QMbP6Xe6wbw@mail.gmail.com>
	<CAG+qjJ9qWGYe0m9oFDYU-J=ZM2izS=bZeF5=MhDHmzaBPvb3ew@mail.gmail.com>
	<554A4E47.5070505@rafresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <554A4E47.5070505-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Thanks Bob for the quick help.

So at this moment, we do not have a way to explicitly specify the i2c
bus number for pca9548 from modprobe command line, correct?

BR,
Eric

On Thu, May 7, 2015 at 1:24 AM, Bob Feretich
<bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org> wrote:
> On 5/6/2015 9:35 AM, os user wrote:
>>
>> Hi there,
>>
>> For some reasons, we need to assign bus id for the channels of I2c mux
>> pca9548.
>>
>>> From the code, it seems we can use "adap_id" of
>>
>>
>> struct pca954x_platform_mode {
>>    int             adap_id;
>>    unsigned int    deselect_on_exit:1;
>>    unsigned int    class;
>> };
>>
>> But my questions is, can we assign bus id through device tree and
>> modprobe?
>
> I have been meaning to submit a patch for this to the documentation. I'll
> get to it soon. See attachment on how to assign i2c bus numbers from the DT.
> -Bob
>>
>>
>> Thanks.
>>
>> On Thu, May 7, 2015 at 12:33 AM, os user <gnusercn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>
>>> Hi there,
>>>
>>> For some reasons, we need to assign bus id for the channels of I2c mux
>>> pca9548.
>>>
>>>  From the code, it seems we can use "adap_id" of
>>>
>>> struct pca954x_platform_mode {
>>>    int             adap_id;
>>>    unsigned int    deselect_on_exit:1;
>>>    unsigned int    class;
>>> };
>>>
>>> But my questions is, can we assign bus id through device tree and
>>> modprobe?
>>>
>>> Thanks.
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

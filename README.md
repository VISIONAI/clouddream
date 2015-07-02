# A Dockerized deepdream Cloud Deamon

Google recently released the
[deepdream](https://github.com/google/deepdream) software package
which uses the Caffe Deep Learning Library and all of the code runs in
an iPython notebook.

So let's make it brain-dead simple to launch your very own
deepdreaming server (in the cloud, on an Ubuntu machine, Mac via
Docker, and maybe even Windows if you try out Kitematic by Docker)!

### Motivation

Because the installation procedure
for [Caffe](http://caffe.berkeleyvision.org/) is not trivial, I
decided to create a self-contained Caffe/deepdream Docker image which has everything
you need to generate your own deepdream art. In order to make the
image very portable, it uses the CPU version of Caffe and comes
bundled with the GoogLeNet model.

The compilation procedure was done on Docker Hub and the final image can be pulled down via

```
docker pull visionai/clouddream
```

For those of you who are new to Docker, I hope you will pick up some
valuable engineering skills and tips along the way. Docker makes it very easy
to bundle complex software.  If you're somebody like me who likes a
clean Mac OS X on a personal laptop, and do the heavy-lifting in the
cloud, then read on.

# Instructions for use

We will be monitoring the `inputs` directory for source images and
dumping results into the `outputs` directory.  Additionally, there is a
simple http server running on port 80 which server the resulting
images.

Prerequisite:

You've launched a Cloud instance using a VPS provider like
DigitalOcean and this instance has Docker running. If you don't know
about DigitalOcean, then you should give them a try.  You can lauch a
Docker-ready cloud instance in a few minutes.  If you're going to set
up a new DigitalOcean account, consider using my referral link:
[https://www.digitalocean.com/?refcode=64f90f652091](https://www.digitalocean.com/?refcode=64f90f652091).

Let's say our cloud instance is at the address 1.2.3.4

```
ssh root@1.2.3.4
git clone https://github.com/VISIONAI/clouddream.git
./start.sh
```

Then from your local machine you can just scp images into the `inputs`
directory inside deepdream as follows:

```
#From your local machine
scp "images/*jpg" root@1.2.3.4:~/clouddream/deepdream/inputs/
```

You should now be able to visit `http://1.2.3.4` in your browser and
see the resulting images appear one by one.

### Changing the default parameters
Inside deepdream.py you'll notice that I'm using

```python
frame = deepdream(net, img, end='conv2/3x3')
```

But you can try different layers such as:

```python
frame = deepdream(net, img, end='inception_3b/5x5_reduce')
```

### Feeding deepdream your own images

You can prepopulate the `inputs` directory with a flat directory of
jpeg images, or you can scp them from you local machine.

I applied this demo to all of the images in the PASCAL VOC 2011
dataset.  You can find the resulting images on the
[deepdream.vision.ai](http://deepdream.vision.ai) server.

### Credits

The included Dockerfile is an extended version of
https://github.com/taras-sereda/docker_ubuntu_caffe

Which is a modification from the original Caffe CPU master Dockerfile tleyden:
https://github.com/tleyden/docker/tree/master/caffe/cpu/master

This dockerfile uses the deepdream code from:
https://github.com/google/deepdream

### License

MIT License. Have fun. Never stop learning.

--Enjoy!
The vision.ai team



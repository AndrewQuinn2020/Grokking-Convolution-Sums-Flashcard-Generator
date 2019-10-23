# conv-histogram-picture-generator.jl

# This code will generate a bunch of easy, but random, convolution, and then two pictures apiece: One showing the x[n] and h[n] as two separate histograms; the next, showing x[n] and x[n]*h[n]=h[n]*x[n] as a new histogram.

using DSP, Plots



#---------------------------------------------------------#

# First, let's test to make sure this works out correctly.

print("\n\n\n")
println("Hello, Julia! Long time no see! :)")



#---------------------------------------------------------#

println("Okay, let's start easy with an example of conv().")

x0 = conv([1 1], [1 2])

println("x0 = $(x0)")

println("Works like a charm. :)")



#---------------------------------------------------------#

# Okay, so now we need to actually generate some histograms.
# Time to dive back into the Plots documentation.

LENGTH = 5
x = rand((-1,0,1), LENGTH)
h = rand((-1,0,1), LENGTH)
y = conv(x, h)

plot(1:LENGTH, [x,h], seriestype=:bar)

# Okay, that's starting to look like what we want.



#---------------------------------------------------------#

# Let's first figure out how to plot x as a histogram.

LENGTH = 12
x = rand((-1,0,1), LENGTH)
plot(1:LENGTH, x, seriestype=:bar)

# Okay, that seems to work. Now let's see if we can get x and h.


LENGTH = 5
x = rand((-1,0,1), LENGTH)
h = rand((-1,0,1), LENGTH)
y = conv(x, h)

p1 = plot(1:LENGTH, x,
          seriestype=:bar,
          title="x[n]",
          linealpha=0,
          color=:blue,
          alpha=0.7,
          legend=:none)
plot!(showaxis=true)
plot!(ylims=(-1,1))

p2 = plot(1:LENGTH, h,
          seriestype=:bar,
          title="h[n]",
          linealpha=0,
          color=:grey,
          alpha=0.7,
          legend=:none)
plot!(showaxis=true)
plot!(ylims=(-1,1))

p3 = plot(1:LENGTH*2-1,
          y,
          seriestype=:bar,
          linealpha=0,
          alpha=0.7,
          color=:red)
plot!(1:LENGTH*2-1,
      [x;zeros(LENGTH-1)],
      seriestype=:bar,
      linealpha=0,
      alpha=0.2,
      color=:blue,
      legend=:none)
plot!(1:LENGTH*2-1,
      [h;zeros(LENGTH-1)],
       seriestype=:bar,
       linealpha=0,
       alpha=0.1,
       color=:grey)
plot!(title="y[n] = x[n] * h[n] = h[n] * x[n]")
plot!(ylims=(-5,5))
plot!(showaxis=true)
plot!(minorgrid=true)

l = @layout [a b; c]
plot(p1, p2, p3, layout = l)

# Sweet! Looks like we're really playing with fire now.



#---------------------------------------------------------#

# Okay, so now, I have to think here. How do I want to actually
# generate these? What would be useful?

# I think that 4 or 5 data points is about the sweet spot for this.
# That's few enough that I can visualize the two going together well.
# Let's generate a bunch of cards with that.

question_layout = @layout[a;b]
plot(p1, p2, layout = question_layout)



#---------------------------------------------------------#


answer_layout = @layout[a b;c]
plot(p3)
plot!(legend=true)
plot!(label=["y[n]" "x[n]" "h[n]"])
